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

private extension String {
    func hasAnyKeyword(_ keywords: [String]) -> Bool {
        keywords.contains { self.contains($0) }
    }
}

extension GroceryCategory {
    static func infer(from name: String) -> GroceryCategory {
        let n = name.lowercased()
        if n.hasAnyKeyword(["dal", "toor", "chana", "masoor", "chickpea", "lentil", "rajma", "moong", "legume", "pulse"]) { return .legumes }
        if n.hasAnyKeyword(["rice", "basmati", "wheat", "flour", "oat", "grain", "semolina", "rava", "poha"]) { return .grains }
        if n.hasAnyKeyword(["paneer", "milk", "curd", "yogurt", "cream", "butter", "ghee", "cheese", "egg"]) { return .dairy }
        if n.hasAnyKeyword(["cashew", "almond", "peanut", "walnut", "pistachio", "sesame", "melon seed", "nut", "seed"]) { return .nuts }
        if n.hasAnyKeyword(["cauliflower", "potato", "aloo", "onion", "tomato", "capsicum", "bell pepper",
                             "spinach", "carrot", "peas", "gobi", "ginger", "garlic", "green chilli", "green chili"]) { return .vegetables }
        if n.hasAnyKeyword(["turmeric", "cumin", "coriander", "garam masala", "chilli", "chili", "pepper",
                             "cardamom", "cinnamon", "clove", "star anise", "bay leaf", "asafoetida", "hing",
                             "ajwain", "carom", "kasuri methi", "methi", "amchur", "mango powder", "kashmiri",
                             "oregano", "mint", "masala"]) { return .herbs }
        if n.hasAnyKeyword(["oil", "salt", "sugar", "vinegar", "baking soda", "lemon", "tamarind"]) { return .pantry }
        if n.hasAnyKeyword(["bread", "bun", "naan", "paratha", "roti", "kulcha", "sandwich"]) { return .bakery }
        return .other
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
