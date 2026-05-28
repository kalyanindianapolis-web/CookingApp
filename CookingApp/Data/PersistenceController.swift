import CoreData
import CloudKit

class PersistenceController {
    static let shared = PersistenceController()

    // Stored as base type so it works with or without CloudKit entitlement.
    // Cast to NSPersistentCloudKitContainer in SharingManager when needed.
    let container: NSPersistentContainer

    var context: NSManagedObjectContext { container.viewContext }

    // True only when the iCloud container identifier entitlement is present.
    static var cloudKitEnabled: Bool {
        let ids = Bundle.main.object(forInfoDictionaryKey: "com.apple.developer.icloud-container-identifiers") as? [String]
        return ids?.isEmpty == false
    }

    init(inMemory: Bool = false) {
        if Self.cloudKitEnabled {
            container = NSPersistentCloudKitContainer(name: "CookingApp")
        } else {
            container = NSPersistentContainer(name: "CookingApp")
        }

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        if let description = container.persistentStoreDescriptions.first {
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }

        container.loadPersistentStores { _, error in
            if let error {
                print("Core Data load error: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
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
