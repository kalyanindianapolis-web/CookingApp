import Foundation

enum GroceryCategory: String, Codable, CaseIterable {
    case vegetables   = "Vegetables"
    case fruits       = "Fruits"
    case legumes      = "Legumes & Pulses"
    case grains       = "Grains & Cereals"
    case dairy        = "Dairy & Eggs"
    case herbs        = "Herbs & Spices"
    case nuts         = "Nuts & Seeds"
    case frozen       = "Frozen"
    case pantry       = "Pantry"
    case bakery       = "Bakery"
    case other        = "Other"

    var emoji: String {
        switch self {
        case .vegetables: return "🥦"
        case .fruits:     return "🍎"
        case .legumes:    return "🫘"
        case .grains:     return "🌾"
        case .dairy:      return "🧀"
        case .herbs:      return "🌿"
        case .nuts:       return "🥜"
        case .frozen:     return "🧊"
        case .pantry:     return "🫙"
        case .bakery:     return "🍞"
        case .other:      return "📦"
        }
    }
}

struct GroceryItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var quantity: String
    var isChecked: Bool
    var category: GroceryCategory

    init(id: UUID = UUID(), name: String, quantity: String, isChecked: Bool = false, category: GroceryCategory = .other) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.isChecked = isChecked
        self.category = category
    }
}
