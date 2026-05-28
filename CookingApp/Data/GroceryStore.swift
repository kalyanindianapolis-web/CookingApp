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
        let entity = GroceryItemEntity(context: context)
        entity.id = UUID()
        entity.name = name
        entity.quantity = quantity
        entity.isChecked = false
        entity.category = category.rawValue
        PersistenceController.shared.save()
        load()
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
