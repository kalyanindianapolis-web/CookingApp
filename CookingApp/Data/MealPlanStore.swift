import Foundation
import CoreData
import Combine

class MealPlanStore: ObservableObject {
    @Published private(set) var entries: [MealPlanEntry] = []

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

                if affected.contains(where: { $0 is MealPlanEntryEntity }) {
                    self.load()
                }
            }
    }

    func entry(for date: Date, slot: MealSlotType) -> MealPlanEntry? {
        let day = startOfDay(date)
        return entries.first { startOfDay($0.date) == day && $0.slot == slot }
    }

    func set(recipe: Recipe, variation: RecipeVariation? = nil, for date: Date, slot: MealSlotType) {
        let day = startOfDay(date)
        // Remove existing entry for this slot
        clearEntityFor(date: day, slot: slot)
        // Insert new — use the variation's accent/time when one is picked
        let effective = variation.map { recipe.applying($0) } ?? recipe
        let entity = MealPlanEntryEntity(context: context)
        entity.id = UUID()
        entity.date = day
        entity.slot = slot.rawValue
        entity.recipeId = recipe.id
        entity.recipeName = recipe.name
        entity.variationName = variation?.name
        entity.accentHex = effective.accentHex
        entity.cuisine = recipe.cuisine
        entity.totalMinutes = Int32(effective.totalMinutes)
        let household = PersistenceController.shared.currentHousehold(in: context)
        entity.household = household
        PersistenceController.shared.placeInHouseholdStore(entity, household: household, in: context)
        PersistenceController.shared.save()
        load()
    }

    func clear(date: Date, slot: MealSlotType) {
        clearEntityFor(date: startOfDay(date), slot: slot)
        PersistenceController.shared.save()
        load()
    }

    func entries(forWeek weekStart: Date) -> [MealPlanEntry] {
        let start = startOfDay(weekStart)
        let end = Calendar.current.date(byAdding: .day, value: 7, to: start)!
        return entries.filter { $0.date >= start && $0.date < end }
    }

    private func clearEntityFor(date: Date, slot: MealSlotType) {
        let request = NSFetchRequest<MealPlanEntryEntity>(entityName: "MealPlanEntryEntity")
        request.predicate = NSPredicate(
            format: "date == %@ AND slot == %@",
            date as CVarArg, slot.rawValue
        )
        let entities = (try? context.fetch(request)) ?? []
        entities.forEach { context.delete($0) }
    }

    private func load() {
        let request = NSFetchRequest<MealPlanEntryEntity>(entityName: "MealPlanEntryEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        let entities = (try? context.fetch(request)) ?? []
        entries = entities.compactMap { entity in
            guard let id = entity.id,
                  let date = entity.date,
                  let slotRaw = entity.slot,
                  let slot = MealSlotType(rawValue: slotRaw),
                  let recipeId = entity.recipeId,
                  let recipeName = entity.recipeName else { return nil }
            return MealPlanEntry(
                id: id,
                date: date,
                slot: slot,
                recipeId: recipeId,
                recipeName: recipeName,
                accentHex: entity.accentHex ?? "E53935",
                cuisine: entity.cuisine ?? "",
                totalMinutes: Int(entity.totalMinutes),
                variationName: entity.variationName
            )
        }
    }

    private func startOfDay(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
}
