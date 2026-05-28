import Foundation

enum MealSlotType: String, Codable, CaseIterable {
    case breakfast = "Breakfast"
    case lunch     = "Lunch"
    case dinner    = "Dinner"

    var mealType: MealType {
        self == .breakfast ? .breakfast : .lunchDinner
    }

    var icon: String {
        switch self {
        case .breakfast: return "sunrise.fill"
        case .lunch:     return "sun.max.fill"
        case .dinner:    return "moon.stars.fill"
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

    init(date: Date, slot: MealSlotType, recipe: Recipe) {
        self.id = UUID()
        self.date = date
        self.slot = slot
        self.recipeId = recipe.id
        self.recipeName = recipe.name
        self.accentHex = recipe.accentHex
        self.cuisine = recipe.cuisine
        self.totalMinutes = recipe.totalMinutes
    }

    init(id: UUID, date: Date, slot: MealSlotType, recipeId: UUID, recipeName: String, accentHex: String, cuisine: String, totalMinutes: Int) {
        self.id = id
        self.date = date
        self.slot = slot
        self.recipeId = recipeId
        self.recipeName = recipeName
        self.accentHex = accentHex
        self.cuisine = cuisine
        self.totalMinutes = totalMinutes
    }
}
