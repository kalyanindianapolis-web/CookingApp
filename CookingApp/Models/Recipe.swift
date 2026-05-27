import Foundation

struct RecipeVariation: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let accentHex: String
    let totalMinutes: Int
    let ingredients: [Ingredient]
    let steps: [Step]
    let imageName: String?

    init(id: UUID = UUID(), name: String, accentHex: String, totalMinutes: Int, ingredients: [Ingredient], steps: [Step], imageName: String? = nil) {
        self.id = id
        self.name = name
        self.accentHex = accentHex
        self.totalMinutes = totalMinutes
        self.ingredients = ingredients
        self.steps = steps
        self.imageName = imageName
    }
}

struct Recipe: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var cuisine: String
    var difficulty: Difficulty
    var totalMinutes: Int
    var defaultServings: Int
    var sfSymbol: String
    var accentHex: String
    var isMultiDish: Bool
    var mealType: MealType
    var ingredients: [Ingredient]
    var steps: [Step]
    var variations: [RecipeVariation]?
    var baseLabel: String?
    var imageName: String?

    init(
        id: UUID = UUID(),
        name: String,
        cuisine: String,
        difficulty: Difficulty,
        totalMinutes: Int,
        defaultServings: Int,
        sfSymbol: String = "fork.knife",
        accentHex: String,
        isMultiDish: Bool = false,
        mealType: MealType = .lunchDinner,
        ingredients: [Ingredient],
        steps: [Step],
        variations: [RecipeVariation]? = nil,
        baseLabel: String? = nil,
        imageName: String? = nil
    ) {
        self.id = id
        self.name = name
        self.cuisine = cuisine
        self.difficulty = difficulty
        self.totalMinutes = totalMinutes
        self.defaultServings = defaultServings
        self.sfSymbol = sfSymbol
        self.accentHex = accentHex
        self.isMultiDish = isMultiDish
        self.mealType = mealType
        self.ingredients = ingredients
        self.steps = steps
        self.variations = variations
        self.baseLabel = baseLabel
        self.imageName = imageName
    }

    func applying(_ variation: RecipeVariation) -> Recipe {
        var copy = self
        copy.ingredients = variation.ingredients
        copy.steps = variation.steps
        copy.accentHex = variation.accentHex
        copy.totalMinutes = variation.totalMinutes
        copy.imageName = variation.imageName ?? self.imageName
        copy.variations = nil
        return copy
    }
}

enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

enum MealType: String, CaseIterable, Codable {
    case breakfast   = "Breakfast"
    case lunchDinner = "Lunch & Dinner"
}

struct Ingredient: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var amount: Double
    var unit: String

    init(id: UUID = UUID(), name: String, amount: Double, unit: String) {
        self.id = id
        self.name = name
        self.amount = amount
        self.unit = unit
    }

    func scaled(to servings: Int, from defaultServings: Int) -> Ingredient {
        let factor = Double(servings) / Double(defaultServings)
        return Ingredient(name: name, amount: amount * factor, unit: unit)
    }

    private static let fractions: [(Double, String)] = [
        (0, ""), (1/8, "1/8"), (1/4, "1/4"), (1/3, "1/3"),
        (3/8, "3/8"), (1/2, "1/2"), (5/8, "5/8"),
        (2/3, "2/3"), (3/4, "3/4"), (7/8, "7/8")
    ]

    var displayAmount: String {
        if amount >= 20 {
            let rounded = Int((amount / 5).rounded() * 5)
            return "\(rounded) \(unit)"
        }
        if amount >= 10 {
            return "\(Int(amount.rounded())) \(unit)"
        }
        let whole = Int(amount)
        let fractional = amount - Double(whole)
        let nearest = Self.fractions.min(by: { abs($0.0 - fractional) < abs($1.0 - fractional) })!
        let adjustedWhole: Int
        let fracStr: String
        if fractional < 0.05 {
            adjustedWhole = whole; fracStr = ""
        } else if nearest.0 > 0.94 {
            adjustedWhole = whole + 1; fracStr = ""
        } else {
            adjustedWhole = whole; fracStr = nearest.1
        }
        if fracStr.isEmpty { return "\(adjustedWhole) \(unit)" }
        return adjustedWhole == 0 ? "\(fracStr) \(unit)" : "\(adjustedWhole) \(fracStr) \(unit)"
    }
}

struct Step: Identifiable, Hashable, Codable {
    let id: UUID
    var order: Int
    var instruction: String
    var tip: String?
    var timerSeconds: Int?

    init(id: UUID = UUID(), order: Int, instruction: String, tip: String? = nil, timerSeconds: Int? = nil) {
        self.id = id
        self.order = order
        self.instruction = instruction
        self.tip = tip
        self.timerSeconds = timerSeconds
    }
}
