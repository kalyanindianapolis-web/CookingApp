import Foundation
import CoreData
import Combine

class GroceryStore: ObservableObject {
    @Published var items: [GroceryItem] = []

    var uncheckedItems: [GroceryItem] { items.filter { !$0.isChecked } }
    var checkedItems: [GroceryItem]   { items.filter { $0.isChecked } }

    private let context = PersistenceController.shared.context
    private var cancellable: AnyCancellable?

    init() {
        load()
        cancellable = NotificationCenter.default
            .publisher(for: .NSManagedObjectContextObjectsDidChange, object: context)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                guard let self else { return }
                let affected = [
                    notification.userInfo?[NSInsertedObjectsKey],
                    notification.userInfo?[NSUpdatedObjectsKey],
                    notification.userInfo?[NSDeletedObjectsKey]
                ]
                .compactMap { $0 as? Set<NSManagedObject> }
                .flatMap { $0 }

                if affected.contains(where: { $0 is GroceryItemEntity }) {
                    self.load()
                }
            }
    }

    func add(name: String, quantity: String, category: GroceryCategory = .other) {
        // Merge into an existing unchecked item of the same name rather than
        // creating a duplicate (e.g. the same ingredient from two recipes).
        if let existing = fetchUncheckedEntity(named: name) {
            existing.quantity = Self.combinedQuantity(existing.quantity ?? "", quantity)
            PersistenceController.shared.save()
            load()
            return
        }
        let entity = GroceryItemEntity(context: context)
        entity.id = UUID()
        entity.name = name
        entity.quantity = quantity
        entity.isChecked = false
        entity.category = category.rawValue
        PersistenceController.shared.save()
        load()
    }

    private func fetchUncheckedEntity(named name: String) -> GroceryItemEntity? {
        let request = NSFetchRequest<GroceryItemEntity>(entityName: "GroceryItemEntity")
        request.predicate = NSPredicate(format: "name ==[c] %@ AND isChecked == NO", name)
        return try? context.fetch(request).first
    }

    /// Combines two grocery quantity strings. Sums them when both are a plain
    /// "<number> <unit>" with matching units; otherwise joins with " + " so
    /// nothing is lost (e.g. fractions like "1/2 cup" or mixed units).
    static func combinedQuantity(_ a: String, _ b: String) -> String {
        let a = a.trimmingCharacters(in: .whitespaces)
        let b = b.trimmingCharacters(in: .whitespaces)
        if a.isEmpty { return b }
        if b.isEmpty { return a }
        if let (na, ua) = parseQuantity(a),
           let (nb, ub) = parseQuantity(b),
           ua.lowercased() == ub.lowercased() {
            let sum = na + nb
            let numStr = sum == sum.rounded() ? String(Int(sum)) : String(format: "%g", sum)
            return ub.isEmpty ? numStr : "\(numStr) \(ub)"
        }
        return "\(a) + \(b)"
    }

    /// Parses a leading decimal number and trailing unit. Returns nil for
    /// fraction strings (e.g. "1 1/2 cup") so those fall back to a " + " join.
    private static func parseQuantity(_ q: String) -> (Double, String)? {
        let scanner = Scanner(string: q)
        scanner.charactersToBeSkipped = .whitespaces
        guard let n = scanner.scanDouble() else { return nil }
        let rest = String(q[scanner.currentIndex...]).trimmingCharacters(in: .whitespaces)
        if rest.contains("/") { return nil }
        return (n, rest)
    }

    func toggle(_ item: GroceryItem) {
        let request = NSFetchRequest<GroceryItemEntity>(entityName: "GroceryItemEntity")
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        if let entity = try? context.fetch(request).first {
            entity.isChecked.toggle()
            PersistenceController.shared.save()
            load()
        }
    }

    func delete(at offsets: IndexSet, from list: [GroceryItem]) {
        let ids = offsets.map { list[$0].id }
        ids.forEach { deleteByID($0) }
    }

    func delete(_ item: GroceryItem) {
        deleteByID(item.id)
    }

    func clearChecked() {
        let request = NSFetchRequest<GroceryItemEntity>(entityName: "GroceryItemEntity")
        request.predicate = NSPredicate(format: "isChecked == YES")
        let entities = (try? context.fetch(request)) ?? []
        entities.forEach { context.delete($0) }
        PersistenceController.shared.save()
        load()
    }

    private func deleteByID(_ id: UUID) {
        let request = NSFetchRequest<GroceryItemEntity>(entityName: "GroceryItemEntity")
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        if let entity = try? context.fetch(request).first {
            context.delete(entity)
            PersistenceController.shared.save()
            load()
        }
    }

    private func load() {
        let request = NSFetchRequest<GroceryItemEntity>(entityName: "GroceryItemEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let entities = (try? context.fetch(request)) ?? []
        items = entities.map { entity in
            GroceryItem(
                id: entity.id ?? UUID(),
                name: entity.name ?? "",
                quantity: entity.quantity ?? "",
                isChecked: entity.isChecked,
                category: GroceryCategory(rawValue: entity.category ?? "") ?? .other
            )
        }
    }
}
