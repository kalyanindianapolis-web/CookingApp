import SwiftUI

struct AddRecipeView: View {
    @EnvironmentObject var store: RecipeStore
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var sfSymbol = "fork.knife"
    @State private var cuisine = "North Indian"
    @State private var difficulty: Difficulty = .easy
    @State private var totalMinutes = 30
    @State private var defaultServings = 2
    @State private var accentHex = "FF6B35"
    @State private var isMultiDish = false
    @State private var mealType: MealType = .lunchDinner

    @State private var ingredients: [DraftIngredient] = [DraftIngredient()]
    @State private var steps: [DraftStep] = [DraftStep(order: 1)]

    @State private var showSymbolPicker = false
    @State private var showValidationAlert = false

    private let cuisineOptions = ["North Indian", "South Indian", "Hyderabadi", "Gujarati", "Bengali", "Punjabi", "Maharashtrian", "Other"]
    private let accentOptions: [(name: String, hex: String)] = [
        ("Orange", "FF6B35"), ("Amber", "FFA62B"), ("Yellow", "FFD60A"),
        ("Green", "4CAF50"), ("Teal", "00897B"), ("Red", "C62828"),
        ("Purple", "7B1FA2"), ("Blue", "1565C0"), ("Brown", "8D6E63")
    ]

    var body: some View {
        NavigationStack {
            Form {
                basicInfoSection
                ingredientsSection
                stepsSection
            }
            .navigationTitle("New Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveRecipe() }
                        .fontWeight(.semibold)
                }
            }
            .alert("Missing Info", isPresented: $showValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please add a recipe name, at least one ingredient, and at least one step.")
            }
        }
    }

    private var basicInfoSection: some View {
        Section("Recipe Info") {
            HStack(spacing: 12) {
                Button {
                    showSymbolPicker.toggle()
                } label: {
                    ZStack {
                        Color(hex: accentHex).opacity(0.15)
                        Image(systemName: sfSymbol)
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(Color(hex: accentHex))
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                .popover(isPresented: $showSymbolPicker) {
                    SymbolPickerView(selectedSymbol: $sfSymbol, accentHex: accentHex)
                        .frame(width: 300, height: 220)
                }

                TextField("Recipe name", text: $name)
                    .font(.headline)
            }
            .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))

            Picker("Cuisine", selection: $cuisine) {
                ForEach(cuisineOptions, id: \.self) { Text($0) }
            }

            Picker("Difficulty", selection: $difficulty) {
                ForEach(Difficulty.allCases, id: \.self) { Text($0.rawValue) }
            }

            Stepper("Total time: \(totalMinutes) min", value: $totalMinutes, in: 5...300, step: 5)

            Stepper("Servings: \(defaultServings)", value: $defaultServings, in: 1...20)

            Picker("Meal Type", selection: $mealType) {
                ForEach(MealType.allCases, id: \.self) { Text($0.rawValue) }
            }

            Toggle("Multi-dish meal", isOn: $isMultiDish)

            VStack(alignment: .leading, spacing: 8) {
                Text("Accent Color")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(accentOptions, id: \.hex) { option in
                            Circle()
                                .fill(Color(hex: option.hex))
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle().stroke(.white, lineWidth: accentHex == option.hex ? 3 : 0)
                                )
                                .overlay(
                                    Circle().stroke(Color(hex: option.hex), lineWidth: accentHex == option.hex ? 2 : 0)
                                        .padding(-2)
                                )
                                .onTapGesture { accentHex = option.hex }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }

    private var ingredientsSection: some View {
        Section {
            ForEach($ingredients) { $ing in
                IngredientRow(ingredient: $ing)
            }
            .onDelete { ingredients.remove(atOffsets: $0) }

            Button {
                ingredients.append(DraftIngredient())
            } label: {
                Label("Add Ingredient", systemImage: "plus.circle.fill")
                    .foregroundStyle(Color(hex: accentHex))
            }
        } header: {
            Text("Ingredients")
        } footer: {
            Text("Swipe left to delete.")
        }
    }

    private var stepsSection: some View {
        Section {
            ForEach($steps) { $step in
                StepRow(step: $step)
            }
            .onDelete { idx in
                steps.remove(atOffsets: idx)
                reorderSteps()
            }

            Button {
                steps.append(DraftStep(order: steps.count + 1))
            } label: {
                Label("Add Step", systemImage: "plus.circle.fill")
                    .foregroundStyle(Color(hex: accentHex))
            }
        } header: {
            Text("Steps")
        } footer: {
            Text("Swipe left to delete.")
        }
    }

    private func reorderSteps() {
        for i in steps.indices { steps[i].order = i + 1 }
    }

    private func saveRecipe() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let validIngredients = ingredients.filter { !$0.name.trimmingCharacters(in: .whitespaces).isEmpty }
        let validSteps = steps.filter { !$0.instruction.trimmingCharacters(in: .whitespaces).isEmpty }

        guard !trimmedName.isEmpty, !validIngredients.isEmpty, !validSteps.isEmpty else {
            showValidationAlert = true
            return
        }

        let recipe = Recipe(
            name: trimmedName,
            cuisine: cuisine,
            difficulty: difficulty,
            totalMinutes: totalMinutes,
            defaultServings: defaultServings,
            sfSymbol: sfSymbol,
            accentHex: accentHex,
            isMultiDish: isMultiDish,
            mealType: mealType,
            ingredients: validIngredients.map {
                Ingredient(name: $0.name, amount: Double($0.amount) ?? 1, unit: $0.unit)
            },
            steps: validSteps.enumerated().map { i, s in
                Step(
                    order: i + 1,
                    instruction: s.instruction,
                    tip: s.tip.isEmpty ? nil : s.tip,
                    timerSeconds: s.timerMinutes > 0 ? s.timerMinutes * 60 : nil
                )
            }
        )

        store.add(recipe)
        dismiss()
    }
}

// MARK: - Draft models

struct DraftIngredient: Identifiable {
    let id = UUID()
    var name = ""
    var amount = ""
    var unit = ""
}

struct DraftStep: Identifiable {
    let id = UUID()
    var order: Int
    var instruction = ""
    var tip = ""
    var timerMinutes = 0
}

// MARK: - Row subviews

struct IngredientRow: View {
    @Binding var ingredient: DraftIngredient

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField("Ingredient name", text: $ingredient.name)
                .font(.subheadline)
            HStack(spacing: 8) {
                TextField("Amount", text: $ingredient.amount)
                    .keyboardType(.decimalPad)
                    .frame(width: 70)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                TextField("Unit (cup, tsp, g…)", text: $ingredient.unit)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct StepRow: View {
    @Binding var step: DraftStep

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 10) {
                Text("\(step.order)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .background(Color.accentColor)
                    .clipShape(Circle())

                TextField("Instruction", text: $step.instruction, axis: .vertical)
                    .font(.subheadline)
                    .lineLimit(3...6)
            }

            TextField("Tip (optional)", text: $step.tip)
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.leading, 34)

            HStack {
                Image(systemName: "timer")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Stepper(
                    step.timerMinutes == 0 ? "No timer" : "Timer: \(step.timerMinutes) min",
                    value: $step.timerMinutes, in: 0...120
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.leading, 34)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Symbol picker

struct SymbolPickerView: View {
    @Binding var selectedSymbol: String
    let accentHex: String
    @Environment(\.dismiss) private var dismiss

    private let symbols = [
        "fork.knife", "flame.fill", "leaf.fill", "drop.fill",
        "star.fill", "sparkles", "sun.max.fill", "heart.fill",
        "waveform", "bolt.fill", "snowflake", "globe"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Pick an icon")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 12)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 14) {
                ForEach(symbols, id: \.self) { symbol in
                    Button {
                        selectedSymbol = symbol
                        dismiss()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedSymbol == symbol
                                      ? Color(hex: accentHex).opacity(0.2)
                                      : Color(uiColor: .systemGray5))
                            Image(systemName: symbol)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(selectedSymbol == symbol
                                                 ? Color(hex: accentHex)
                                                 : Color.primary)
                        }
                        .frame(width: 40, height: 40)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
    }
}

#Preview {
    AddRecipeView().environmentObject(RecipeStore())
}
