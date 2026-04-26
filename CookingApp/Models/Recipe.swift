import Foundation

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
    var ingredients: [Ingredient]
    var steps: [Step]

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
        ingredients: [Ingredient],
        steps: [Step]
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
        self.ingredients = ingredients
        self.steps = steps
    }
}

enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
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

    var displayAmount: String {
        if amount == amount.rounded() {
            return "\(Int(amount)) \(unit)"
        }
        return String(format: "%.4g %@", amount, unit)
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
