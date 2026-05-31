import Foundation
import CoreData
import Combine

class RecipeStore: ObservableObject {
    @Published private(set) var userRecipes: [Recipe] = []
    @Published private(set) var remoteRecipes: [Recipe] = []

    // Seed + HA remote (deduplicated by id) + user-added
    var allRecipes: [Recipe] {
        let seedIDs = Set(SeedRecipes.all.map(\.id))
        let deduped = remoteRecipes.filter { !seedIDs.contains($0.id) }
        return SeedRecipes.all + deduped + userRecipes
    }

    func updateRemoteRecipes(_ recipes: [Recipe]) {
        remoteRecipes = recipes
    }

    private let context = PersistenceController.shared.context
    private var cancellable: AnyCancellable?

    init() {
        load()
        // Refresh when CloudKit syncs remote changes into the context
        cancellable = NotificationCenter.default
            .publisher(for: .NSManagedObjectContextObjectsDidChange, object: context)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                guard let self else { return }
                let affected = [
                    notification.userInfo?[NSInsertedObjectsKey],
                    notification.userInfo?[NSUpdatedObjectsKey],
                    notification.userInfo?[NSDeletedObjectsKey]
                ]
                .compactMap { $0 as? Set<NSManagedObject> }
                .flatMap { $0 }

                if affected.contains(where: { $0 is RecipeEntity }) {
                    self.load()
                }
            }
    }

    func add(_ recipe: Recipe) {
        let entity = RecipeEntity(context: context)
        entity.id = recipe.id
        entity.jsonData = try? JSONEncoder().encode(recipe)
        PersistenceController.shared.save()
        load()
    }

    func update(_ recipe: Recipe) {
        let request = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
        request.predicate = NSPredicate(format: "id == %@", recipe.id as CVarArg)
        if let entity = try? context.fetch(request).first {
            entity.jsonData = try? JSONEncoder().encode(recipe)
            PersistenceController.shared.save()
            load()
        }
    }

    func delete(_ recipe: Recipe) {
        let request = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
        request.predicate = NSPredicate(format: "id == %@", recipe.id as CVarArg)
        if let entity = try? context.fetch(request).first {
            context.delete(entity)
            PersistenceController.shared.save()
            load()
        }
    }

    func isUserRecipe(_ recipe: Recipe) -> Bool {
        userRecipes.contains { $0.id == recipe.id }
    }

    private func load() {
        let request = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
        let entities = (try? context.fetch(request)) ?? []
        userRecipes = entities.compactMap { entity in
            guard let data = entity.jsonData else { return nil }
            return try? JSONDecoder().decode(Recipe.self, from: data)
        }
    }
}
