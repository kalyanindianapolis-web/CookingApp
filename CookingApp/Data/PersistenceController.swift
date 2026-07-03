import CoreData
import CloudKit

class PersistenceController {
    static let shared = PersistenceController()

    // Stored as base type so it works with or without CloudKit entitlement.
    // Cast to NSPersistentCloudKitContainer in SharingManager when needed.
    let container: NSPersistentContainer

    // Set when running with CloudKit: the private DB store (owner's data) and
    // the shared DB store (data others share with you). Nil on the plain path.
    private(set) var privateStore: NSPersistentStore?
    private(set) var sharedStore: NSPersistentStore?

    var context: NSManagedObjectContext { container.viewContext }

    private let containerIdentifier = "iCloud.com.kalyan.CookingApp"

    // ubiquityIdentityToken is non-nil only when the app is actually entitled
    // for iCloud AND the user is signed in. It never crashes (unlike
    // CKContainer.default() called without the entitlement), so it's a safe
    // gate: false on unsigned/simulator builds and when iCloud is unavailable,
    // true only when it's safe to use CloudKit.
    static var cloudKitEnabled: Bool {
        FileManager.default.ubiquityIdentityToken != nil
    }

    init(inMemory: Bool = false) {
        let useCloudKit = Self.cloudKitEnabled && !inMemory
        if useCloudKit {
            container = NSPersistentCloudKitContainer(name: "CookingApp")
        } else {
            container = NSPersistentContainer(name: "CookingApp")
        }

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        } else if useCloudKit, let cloud = container as? NSPersistentCloudKitContainer {
            configureCloudKitStores(cloud)
        }

        // History tracking + remote-change notifications on every store so both
        // the private and shared stores sync and merge into the view context.
        for description in container.persistentStoreDescriptions {
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }

        container.loadPersistentStores { _, error in
            if let error {
                print("Core Data load error: \(error)")
            }
        }

        // Capture the private/shared store references (local stores load
        // synchronously, so they're present by now). Matched by file name.
        if useCloudKit {
            for store in container.persistentStoreCoordinator.persistentStores {
                if store.url?.lastPathComponent.contains("shared") == true {
                    sharedStore = store
                } else {
                    privateStore = store
                }
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    /// Configures the container with a private (.private) and shared (.shared)
    /// CloudKit store on the same iCloud container. The shared store is where
    /// data others share with you (via CKShare) lands.
    private func configureCloudKitStores(_ container: NSPersistentCloudKitContainer) {
        let baseURL = NSPersistentContainer.defaultDirectoryURL()

        let privateDesc = NSPersistentStoreDescription(url: baseURL.appendingPathComponent("CookingApp.sqlite"))
        let privateOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: containerIdentifier)
        privateOptions.databaseScope = .private
        privateDesc.cloudKitContainerOptions = privateOptions

        let sharedDesc = NSPersistentStoreDescription(url: baseURL.appendingPathComponent("CookingApp-shared.sqlite"))
        let sharedOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: containerIdentifier)
        sharedOptions.databaseScope = .shared
        sharedDesc.cloudKitContainerOptions = sharedOptions

        container.persistentStoreDescriptions = [privateDesc, sharedDesc]
    }

    // MARK: - Household

    /// Returns the household to attach new items to: a shared one (participant)
    /// if present, otherwise the local/private one, creating it if needed.
    func currentHousehold(in context: NSManagedObjectContext) -> HouseholdEntity {
        let request = NSFetchRequest<HouseholdEntity>(entityName: "HouseholdEntity")
        let households = (try? context.fetch(request)) ?? []
        if sharedStore != nil, let shared = households.first(where: { $0.objectID.persistentStore == sharedStore }) {
            return shared
        }
        if let existing = households.first {
            return existing
        }
        let household = HouseholdEntity(context: context)
        household.id = UUID()
        household.name = "Our Household"
        household.createdAt = Date()
        if let privateStore {
            context.assign(household, to: privateStore)
        }
        return household
    }

    /// Keeps a new object in the same store as its household — Core Data does
    /// not allow relationships that cross persistent stores.
    func placeInHouseholdStore(_ object: NSManagedObject, household: HouseholdEntity, in context: NSManagedObjectContext) {
        if let store = household.objectID.persistentStore {
            context.assign(object, to: store)
        }
    }

    func save() {
        guard context.hasChanges else { return }
        try? context.save()
    }

    // MARK: - One-time migration from UserDefaults

    func migrateLegacyDataIfNeeded() {
        migrateRecipes()
        migrateGroceryItems()
        migrateMealPlan()
        backfillHouseholdIfNeeded()
    }

    /// Assigns any items that predate the Household model (build 4 users, or the
    /// legacy migration above) to a single local household, once.
    private func backfillHouseholdIfNeeded() {
        let flag = "didBackfillHousehold_v1"
        guard !UserDefaults.standard.bool(forKey: flag) else { return }

        let household = currentHousehold(in: context)
        assignOrphans(entityName: "GroceryItemEntity", to: household)
        assignOrphans(entityName: "MealPlanEntryEntity", to: household)
        assignOrphans(entityName: "RecipeEntity", to: household)
        save()
        UserDefaults.standard.set(true, forKey: flag)
    }

    private func assignOrphans(entityName: String, to household: HouseholdEntity) {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.predicate = NSPredicate(format: "household == nil")
        let orphans = (try? context.fetch(request)) ?? []
        for orphan in orphans {
            orphan.setValue(household, forKey: "household")
        }
    }

    private func migrateRecipes() {
        let key = "userRecipes"
        guard let data = UserDefaults.standard.data(forKey: key),
              let recipes = try? JSONDecoder().decode([Recipe].self, from: data),
              !recipes.isEmpty else { return }
        for recipe in recipes {
            let entity = RecipeEntity(context: context)
            entity.id = recipe.id
            entity.jsonData = try? JSONEncoder().encode(recipe)
        }
        save()
        UserDefaults.standard.removeObject(forKey: key)
    }

    private func migrateGroceryItems() {
        let key = "groceryItems"
        guard let data = UserDefaults.standard.data(forKey: key),
              let items = try? JSONDecoder().decode([GroceryItem].self, from: data),
              !items.isEmpty else { return }
        for item in items {
            let entity = GroceryItemEntity(context: context)
            entity.id = item.id
            entity.name = item.name
            entity.quantity = item.quantity
            entity.isChecked = item.isChecked
            entity.category = item.category.rawValue
        }
        save()
        UserDefaults.standard.removeObject(forKey: key)
    }

    private func migrateMealPlan() {
        let key = "mealPlanEntries"
        guard let data = UserDefaults.standard.data(forKey: key),
              let entries = try? JSONDecoder().decode([MealPlanEntry].self, from: data),
              !entries.isEmpty else { return }
        for entry in entries {
            let entity = MealPlanEntryEntity(context: context)
            entity.id = entry.id
            entity.date = entry.date
            entity.slot = entry.slot.rawValue
            entity.recipeId = entry.recipeId
            entity.recipeName = entry.recipeName
            entity.accentHex = entry.accentHex
            entity.cuisine = entry.cuisine
            entity.totalMinutes = Int32(entry.totalMinutes)
        }
        save()
        UserDefaults.standard.removeObject(forKey: key)
    }
}
