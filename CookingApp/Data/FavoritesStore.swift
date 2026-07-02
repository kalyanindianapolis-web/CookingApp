import Foundation
import Combine

/// Tracks which recipes are marked favorite. Backed by UserDefaults keyed on the
/// recipe's stable UUID, so it works uniformly across seed, Home Assistant, and
/// user recipes without touching the Core Data model.
class FavoritesStore: ObservableObject {
    @Published private(set) var favoriteIDs: Set<UUID> = []

    private let key = "favorite_recipe_ids"

    init() {
        load()
    }

    func isFavorite(_ recipe: Recipe) -> Bool {
        favoriteIDs.contains(recipe.id)
    }

    func toggle(_ recipe: Recipe) {
        if favoriteIDs.contains(recipe.id) {
            favoriteIDs.remove(recipe.id)
        } else {
            favoriteIDs.insert(recipe.id)
        }
        save()
    }

    private func load() {
        let strings = UserDefaults.standard.stringArray(forKey: key) ?? []
        favoriteIDs = Set(strings.compactMap(UUID.init))
    }

    private func save() {
        UserDefaults.standard.set(favoriteIDs.map(\.uuidString), forKey: key)
    }
}
