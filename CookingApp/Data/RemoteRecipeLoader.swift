import Foundation
import Combine

// Fetches recipes from a JSON file served by Home Assistant on the local network.
// Caches the last successful fetch so recipes are still available when away from home.
// Triggered on app launch and every time the app returns to the foreground.
class RemoteRecipeLoader: ObservableObject {

    // MARK: - Published state

    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var isFetching = false
    @Published private(set) var lastFetched: Date? = nil

    // MARK: - Configuration (persisted in UserDefaults)

    static let defaultURL = "http://homeassistant.local:8123/local/recipes.json"
    private let urlKey   = "ha_recipe_url"
    private let cacheKey = "ha_remote_recipes_cache"

    var haURL: String {
        get { UserDefaults.standard.string(forKey: urlKey) ?? Self.defaultURL }
        set { UserDefaults.standard.set(newValue, forKey: urlKey) }
    }

    // MARK: - Init

    init() {
        loadCache()
    }

    // MARK: - Fetch

    /// Attempts to reach the HA URL. Silently does nothing if unreachable (away from home).
    func fetchIfReachable() {
        guard let url = URL(string: haURL), !isFetching else { return }

        isFetching = true

        var request = URLRequest(url: url)
        request.timeoutInterval = 5   // fail fast if not on home network

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            DispatchQueue.main.async {
                guard let self else { return }
                self.isFetching = false
                guard let data, error == nil,
                      let recipes = Self.parse(data) else { return }
                self.recipes = recipes
                self.lastFetched = Date()
                UserDefaults.standard.set(data, forKey: self.cacheKey)
            }
        }.resume()
    }

    // MARK: - Cache

    private func loadCache() {
        guard let data = UserDefaults.standard.data(forKey: cacheKey),
              let recipes = Self.parse(data) else { return }
        self.recipes = recipes
    }

    // MARK: - Parsing

    private static func parse(_ data: Data) -> [Recipe]? {
        do {
            let payloads = try JSONDecoder().decode([HARecipePayload].self, from: data)
            return payloads.map(\.asRecipe)
        } catch {
            print("RemoteRecipeLoader: decode failed — \(error)")
            return nil
        }
    }
}

// MARK: - Flexible JSON payload (id is optional, all fields lenient)

private struct HARecipePayload: Decodable {
    var id: String?
    var name: String
    var cuisine: String
    var difficulty: String? = "Medium"
    var totalMinutes: Int
    var defaultServings: Int
    var sfSymbol: String? = "fork.knife"
    var accentHex: String
    var isMultiDish: Bool? = false
    var mealType: String? = "Lunch & Dinner"
    var ingredients: [HAIngredient]
    var steps: [HAStep]
    var imageName: String? = nil

    var asRecipe: Recipe {
        Recipe(
            id: id.flatMap(UUID.init) ?? stableID(for: name),
            name: name,
            cuisine: cuisine,
            difficulty: Difficulty(rawValue: difficulty ?? "Medium") ?? .medium,
            totalMinutes: totalMinutes,
            defaultServings: defaultServings,
            sfSymbol: sfSymbol ?? "fork.knife",
            accentHex: accentHex,
            isMultiDish: isMultiDish ?? false,
            mealType: MealType(rawValue: mealType ?? "Lunch & Dinner") ?? .lunchDinner,
            ingredients: ingredients.map(\.asIngredient),
            steps: steps.map(\.asStep),
            imageName: imageName
        )
    }

    // Deterministic UUID derived from the recipe name so the same recipe
    // always gets the same UUID across fetches (no duplicates on re-fetch).
    private func stableID(for name: String) -> UUID {
        let seed = Data("ha:\(name.lowercased())".utf8)
        var bytes = [UInt8](repeating: 0, count: 16)
        for (i, byte) in seed.enumerated() { bytes[i % 16] ^= byte }
        bytes[6] = (bytes[6] & 0x0F) | 0x40   // version 4
        bytes[8] = (bytes[8] & 0x3F) | 0x80   // variant
        return UUID(uuid: (
            bytes[0],  bytes[1],  bytes[2],  bytes[3],
            bytes[4],  bytes[5],  bytes[6],  bytes[7],
            bytes[8],  bytes[9],  bytes[10], bytes[11],
            bytes[12], bytes[13], bytes[14], bytes[15]
        ))
    }
}

private struct HAIngredient: Decodable {
    var name: String
    var amount: Double
    var unit: String
    var asIngredient: Ingredient { Ingredient(name: name, amount: amount, unit: unit) }
}

private struct HAStep: Decodable {
    var order: Int
    var instruction: String
    var tip: String?
    var timerSeconds: Int?
    var asStep: Step { Step(order: order, instruction: instruction, tip: tip, timerSeconds: timerSeconds) }
}
