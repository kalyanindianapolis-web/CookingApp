import Foundation
import Combine

class RecipeStore: ObservableObject {
    @Published private(set) var userRecipes: [Recipe] = []

    var allRecipes: [Recipe] { SeedRecipes.all + userRecipes }

    private let storageKey = "userRecipes"

    init() {
        load()
    }

    func add(_ recipe: Recipe) {
        userRecipes.append(recipe)
        save()
    }

    func update(_ recipe: Recipe) {
        guard let idx = userRecipes.firstIndex(where: { $0.id == recipe.id }) else { return }
        userRecipes[idx] = recipe
        save()
    }

    func delete(_ recipe: Recipe) {
        userRecipes.removeAll { $0.id == recipe.id }
        save()
    }

    func isUserRecipe(_ recipe: Recipe) -> Bool {
        userRecipes.contains { $0.id == recipe.id }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(userRecipes) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let recipes = try? JSONDecoder().decode([Recipe].self, from: data) else { return }
        userRecipes = recipes
    }
}
