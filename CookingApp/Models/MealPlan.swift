import Foundation

enum MealSlotType: String, Codable, CaseIterable {
    case breakfast = "Breakfast"
    case lunch     = "Lunch"
    case dinner    = "Dinner"
    case snack     = "Snack"

    var mealType: MealType {
        switch self {
        case .breakfast:      return .breakfast
        case .lunch, .dinner: return .lunchDinner
        case .snack:          return .snacks
        }
    }

    var icon: String {
        switch self {
        case .breakfast: return "sunrise.fill"
        case .lunch:     return "sun.max.fill"
        case .dinner:    return "moon.stars.fill"
        case .snack:     return "takeoutbag.and.cup.and.straw.fill"
        }
    }
}

struct MealPlanEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let slot: MealSlotType
    let recipeId: UUID
    let recipeName: String
    let accentHex: String
    let cuisine: String
    let totalMinutes: Int
    let variationName: String?

    /// Name shown in the planner — includes the picked variation when set.
    var displayName: String {
        if let variationName { return "\(recipeName) · \(variationName)" }
        return recipeName
    }

    init(date: Date, slot: MealSlotType, recipe: Recipe, variation: RecipeVariation? = nil) {
        self.id = UUID()
        self.date = date
        self.slot = slot
        self.recipeId = recipe.id
        self.recipeName = recipe.name
        self.variationName = variation?.name
        // Use the variation's accent/time when one is picked.
        let effective = variation.map { recipe.applying($0) } ?? recipe
        self.accentHex = effective.accentHex
        self.cuisine = recipe.cuisine
        self.totalMinutes = effective.totalMinutes
    }

    init(id: UUID, date: Date, slot: MealSlotType, recipeId: UUID, recipeName: String, accentHex: String, cuisine: String, totalMinutes: Int, variationName: String? = nil) {
        self.id = id
        self.date = date
        self.slot = slot
        self.recipeId = recipeId
        self.recipeName = recipeName
        self.accentHex = accentHex
        self.cuisine = cuisine
        self.totalMinutes = totalMinutes
        self.variationName = variationName
    }
}
