import Foundation

struct GroceryItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var quantity: String
    var isChecked: Bool

    init(id: UUID = UUID(), name: String, quantity: String, isChecked: Bool = false) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.isChecked = isChecked
    }
}
