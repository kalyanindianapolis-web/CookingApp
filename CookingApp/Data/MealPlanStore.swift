import Foundation
import Combine

class MealPlanStore: ObservableObject {
    @Published private(set) var entries: [MealPlanEntry] = []
    private let storageKey = "mealPlanEntries"

    init() { load() }

    func entry(for date: Date, slot: MealSlotType) -> MealPlanEntry? {
        let day = startOfDay(date)
        return entries.first { startOfDay($0.date) == day && $0.slot == slot }
    }

    func set(recipe: Recipe, for date: Date, slot: MealSlotType) {
        let day = startOfDay(date)
        entries.removeAll { startOfDay($0.date) == day && $0.slot == slot }
        entries.append(MealPlanEntry(date: day, slot: slot, recipe: recipe))
        save()
    }

    func clear(date: Date, slot: MealSlotType) {
        let day = startOfDay(date)
        entries.removeAll { startOfDay($0.date) == day && $0.slot == slot }
        save()
    }

    func entries(forWeek weekStart: Date) -> [MealPlanEntry] {
        let start = startOfDay(weekStart)
        let end = Calendar.current.date(byAdding: .day, value: 7, to: start)!
        return entries.filter { $0.date >= start && $0.date < end }
    }

    private func startOfDay(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let saved = try? JSONDecoder().decode([MealPlanEntry].self, from: data) else { return }
        entries = saved
    }
}
