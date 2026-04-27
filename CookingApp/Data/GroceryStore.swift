import Foundation
import Combine

class GroceryStore: ObservableObject {
    @Published var items: [GroceryItem] = []

    private let storageKey = "groceryItems"

    init() { load() }

    var uncheckedItems: [GroceryItem] { items.filter { !$0.isChecked } }
    var checkedItems: [GroceryItem] { items.filter { $0.isChecked } }

    func add(name: String, quantity: String, category: GroceryCategory = .other) {
        items.append(GroceryItem(name: name, quantity: quantity, category: category))
        save()
    }

    func toggle(_ item: GroceryItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx].isChecked.toggle()
        save()
    }

    func delete(at offsets: IndexSet, from list: [GroceryItem]) {
        let ids = offsets.map { list[$0].id }
        items.removeAll { ids.contains($0.id) }
        save()
    }

    func clearChecked() {
        items.removeAll { $0.isChecked }
        save()
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let saved = try? JSONDecoder().decode([GroceryItem].self, from: data) else { return }
        items = saved
    }
}
