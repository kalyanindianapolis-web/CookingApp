import SwiftUI

struct MealPlanView: View {
    @EnvironmentObject var mealPlanStore: MealPlanStore
    @EnvironmentObject var recipeStore: RecipeStore
    @EnvironmentObject var groceryStore: GroceryStore

    @State private var selectedDate = Calendar.current.startOfDay(for: Date())
    @State private var weekOffset = 0
    @State private var pickerContext: PickerContext? = nil
    @State private var showAddedBanner = false

    struct PickerContext: Identifiable {
        let id = UUID()
        let date: Date
        let slot: MealSlotType
    }

    private let cal = Calendar.current

    private var weekStart: Date {
        let base = cal.date(byAdding: .weekOfYear, value: weekOffset, to: Date())!
        let comps = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: base)
        return cal.date(from: comps)!
    }

    private var weekDates: [Date] {
        (0..<7).map { cal.date(byAdding: .day, value: $0, to: weekStart)! }
    }

    private var monthYearLabel: String {
        let fmt = DateFormatter()
        fmt.dateFormat = "MMMM yyyy"
        return fmt.string(from: weekStart)
    }

    private var dayLabel: String {
        let fmt = DateFormatter()
        fmt.dateFormat = "EEEE, MMM d"
        return fmt.string(from: selectedDate)
    }

    private var dayEntries: [MealPlanEntry] {
        MealSlotType.allCases.compactMap { mealPlanStore.entry(for: selectedDate, slot: $0) }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                topSection
                    .background(Color(uiColor: .systemGroupedBackground))

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(dayLabel)
                            .font(.system(size: 20, weight: .bold))
                            .tracking(-0.3)
                            .padding(.top, 8)

                        mealDayCard
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
                .background(Color(uiColor: .systemGroupedBackground))
            }
            .navigationBarHidden(true)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                addDayToGroceryButton
                    .background(.ultraThinMaterial)
            }
            .overlay(alignment: .top) {
                if showAddedBanner {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        Text("Added to grocery list")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                    .padding(.top, 60)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .animation(.spring(duration: 0.3), value: showAddedBanner)
            .sheet(item: $pickerContext) { ctx in
                RecipePickerSheet(slot: ctx.slot) { recipe in
                    mealPlanStore.set(recipe: recipe, for: ctx.date, slot: ctx.slot)
                }
                .environmentObject(recipeStore)
            }
        }
    }

    // MARK: - Top section (fixed)

    private var topSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            weekNavRow
            dayStrip
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Planning")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.top, 12)
            Text("Meal Plan")
                .font(.system(size: 32, weight: .bold))
                .tracking(-0.5)
        }
    }

    private var weekNavRow: some View {
        HStack {
            Button {
                weekOffset -= 1
                selectedDate = weekStart
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(width: 30, height: 30)
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.06), radius: 2, y: 1)
            }

            Spacer()

            Text(monthYearLabel)
                .font(.system(size: 14, weight: .semibold))

            Spacer()

            Button {
                weekOffset += 1
                selectedDate = weekStart
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(width: 30, height: 30)
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.06), radius: 2, y: 1)
            }
        }
    }

    private var dayStrip: some View {
        HStack(spacing: 4) {
            ForEach(weekDates, id: \.self) { date in
                DayChip(
                    date: date,
                    isSelected: cal.isDate(date, inSameDayAs: selectedDate)
                ) {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selectedDate = date
                    }
                }
            }
        }
    }

    // MARK: - Meal card

    private var mealDayCard: some View {
        VStack(spacing: 0) {
            ForEach(Array(MealSlotType.allCases.enumerated()), id: \.element) { index, slot in
                MealSlotRow(
                    slot: slot,
                    entry: mealPlanStore.entry(for: selectedDate, slot: slot),
                    onTap: { pickerContext = PickerContext(date: selectedDate, slot: slot) },
                    onClear: { mealPlanStore.clear(date: selectedDate, slot: slot) }
                )
                if index < MealSlotType.allCases.count - 1 {
                    Divider().padding(.leading, 54)
                }
            }
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }

    // MARK: - Bottom button

    private var addDayToGroceryButton: some View {
        Button(action: addDayToGrocery) {
            Label("Add day to grocery list", systemImage: "cart.badge.plus")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(14)
                .background(dayEntries.isEmpty ? Color(uiColor: .systemGray3) : Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .disabled(dayEntries.isEmpty)
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
        .padding(.top, 12)
    }

    private func addDayToGrocery() {
        let dayRecipeIds = Set(dayEntries.map { $0.recipeId })
        let recipes = recipeStore.allRecipes.filter { dayRecipeIds.contains($0.id) }
        var seen: Set<String> = []
        for recipe in recipes {
            for ing in recipe.ingredients {
                let key = ing.groceryName.lowercased()
                guard !seen.contains(key) else { continue }
                seen.insert(key)
                groceryStore.add(
                    name: ing.groceryName,
                    quantity: ing.displayAmount,
                    category: GroceryCategory.infer(from: ing.groceryName)
                )
            }
        }
        showAddedBanner = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showAddedBanner = false
        }
    }
}

// MARK: - DayChip

struct DayChip: View {
    let date: Date
    let isSelected: Bool
    let onTap: () -> Void

    private let cal = Calendar.current

    private var isToday: Bool { cal.isDateInToday(date) }

    private var dayLetter: String {
        let fmt = DateFormatter()
        fmt.dateFormat = "EEEEE"
        return fmt.string(from: date)
    }

    private var dayNumber: String {
        let fmt = DateFormatter()
        fmt.dateFormat = "d"
        return fmt.string(from: date)
    }

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 3) {
                Text(dayLetter)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(isSelected ? .white : .secondary)

                Text(dayNumber)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(isSelected ? .white : .primary)

                Circle()
                    .fill(isSelected ? Color.white.opacity(0.5) : (isToday ? Color.primary : Color.clear))
                    .frame(width: 4, height: 4)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(isSelected ? Color.primary : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - MealSlotRow

struct MealSlotRow: View {
    let slot: MealSlotType
    let entry: MealPlanEntry?
    let onTap: () -> Void
    let onClear: () -> Void

    private var accentColor: Color {
        entry.map { Color(hex: $0.accentHex) } ?? Color(uiColor: .systemGray4)
    }

    var body: some View {
        HStack(spacing: 0) {
            // Left accent bar
            RoundedRectangle(cornerRadius: 2)
                .fill(accentColor)
                .frame(width: 3)
                .padding(.vertical, 14)
                .padding(.leading, 14)

            VStack(alignment: .leading, spacing: 5) {
                // Slot label
                HStack(spacing: 5) {
                    Image(systemName: slot.icon)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(accentColor)
                    Text(slot.rawValue.uppercased())
                        .font(.system(size: 10, weight: .bold))
                        .tracking(0.8)
                        .foregroundStyle(.secondary)
                }

                // Content
                if let entry = entry {
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(entry.recipeName)
                                .font(.system(size: 15, weight: .semibold))
                                .lineLimit(1)
                            Text("\(entry.cuisine) · \(entry.totalMinutes) min")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer(minLength: 8)
                        Button(action: onClear) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(Color(uiColor: .systemGray3))
                        }
                    }
                } else {
                    Text("+ Add \(slot.rawValue.lowercased())")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(uiColor: .systemGray3))
                }
            }
            .padding(.leading, 12)
            .padding(.trailing, 14)
            .padding(.vertical, 14)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}

// MARK: - RecipePickerSheet

struct RecipePickerSheet: View {
    @EnvironmentObject var recipeStore: RecipeStore
    @Environment(\.dismiss) private var dismiss
    let slot: MealSlotType
    let onPick: (Recipe) -> Void

    @State private var searchText = ""

    private var filteredRecipes: [Recipe] {
        recipeStore.allRecipes
            .filter { $0.mealType == slot.mealType }
            .filter { searchText.isEmpty ||
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.searchableIngredients.contains { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    searchBar.padding(.top, 4)

                    if filteredRecipes.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "fork.knife")
                                .font(.system(size: 40, weight: .light))
                                .foregroundStyle(.tertiary)
                                .padding(.top, 40)
                            Text("No \(slot.rawValue.lowercased()) recipes yet")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        ForEach(filteredRecipes) { recipe in
                            Button {
                                onPick(recipe)
                                dismiss()
                            } label: {
                                RecipeCard(recipe: recipe, isUserRecipe: recipeStore.isUserRecipe(recipe))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Pick \(slot.rawValue)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
            TextField("Search recipes", text: $searchText).font(.subheadline)
            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color(uiColor: .systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MealPlanView()
        .environmentObject(MealPlanStore())
        .environmentObject(RecipeStore())
        .environmentObject(GroceryStore())
}
