import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @EnvironmentObject var store: RecipeStore
    @Environment(\.dismiss) private var dismiss

    private let recipeToEdit: Recipe?

    @State private var photoItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    @State private var name: String
    @State private var sfSymbol: String
    @State private var cuisine: String
    @State private var difficulty: Difficulty
    @State private var totalMinutes: Int
    @State private var defaultServings: Int
    @State private var accentHex: String
    @State private var isMultiDish: Bool
    @State private var mealType: MealType

    @State private var ingredients: [DraftIngredient]
    @State private var steps: [DraftStep]

    @State private var showSymbolPicker = false
    @State private var showValidationAlert = false

    init(recipeToEdit: Recipe? = nil) {
        self.recipeToEdit = recipeToEdit
        if let r = recipeToEdit {
            _name = State(initialValue: r.name)
            _sfSymbol = State(initialValue: r.sfSymbol)
            _cuisine = State(initialValue: r.cuisine)
            _difficulty = State(initialValue: r.difficulty)
            _totalMinutes = State(initialValue: r.totalMinutes)
            _defaultServings = State(initialValue: r.defaultServings)
            _accentHex = State(initialValue: r.accentHex)
            _isMultiDish = State(initialValue: r.isMultiDish)
            _mealType = State(initialValue: r.mealType)
            _ingredients = State(initialValue: r.ingredients.map {
                DraftIngredient(name: $0.name, amount: $0.amount == $0.amount.rounded() ? String(Int($0.amount)) : String($0.amount), unit: $0.unit)
            })
            _steps = State(initialValue: r.steps.map {
                DraftStep(order: $0.order, instruction: $0.instruction, tip: $0.tip ?? "", timerSeconds: $0.timerSeconds ?? 0)
            })
            _selectedImageData = State(initialValue: UserRecipeImageStore.data(for: r.id))
        } else {
            _name = State(initialValue: "")
            _sfSymbol = State(initialValue: "fork.knife")
            _cuisine = State(initialValue: "North Indian")
            _difficulty = State(initialValue: .easy)
            _totalMinutes = State(initialValue: 30)
            _defaultServings = State(initialValue: 2)
            _accentHex = State(initialValue: "FF6B35")
            _isMultiDish = State(initialValue: false)
            _mealType = State(initialValue: .lunchDinner)
            _ingredients = State(initialValue: [DraftIngredient()])
            _steps = State(initialValue: [DraftStep(order: 1)])
        }
    }

    private let cuisineOptions = ["North Indian", "South Indian", "Hyderabadi", "Gujarati", "Bengali", "Punjabi", "Maharashtrian", "Other"]
    private let accentOptions: [(name: String, hex: String)] = [
        ("Orange", "FF6B35"), ("Amber", "FFA62B"), ("Yellow", "FFD60A"),
        ("Green", "4CAF50"), ("Teal", "00897B"), ("Red", "C62828"),
        ("Purple", "7B1FA2"), ("Blue", "1565C0"), ("Brown", "8D6E63")
    ]

    var body: some View {
        NavigationStack {
            Form {
                photoSection
                basicInfoSection
                ingredientsSection
                stepsSection
            }
            .onChange(of: photoItem) { _, newItem in
                guard let newItem else { return }
                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                        selectedImageData = normalizedJPEG(from: data) ?? data
                    }
                }
            }
            .navigationTitle(recipeToEdit == nil ? "New Recipe" : "Edit Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveRecipe() }
                        .fontWeight(.semibold)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
            .alert("Missing Info", isPresented: $showValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please add a recipe name, at least one ingredient, and at least one step.")
            }
        }
    }

    private var photoSection: some View {
        Section {
            if let data = selectedImageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 170)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .listRowInsets(EdgeInsets())
            }
            HStack {
                PhotosPicker(selection: $photoItem, matching: .images, photoLibrary: .shared()) {
                    Label(selectedImageData == nil ? "Add Photo" : "Change Photo", systemImage: "photo")
                        .foregroundStyle(Color(hex: accentHex))
                }
                if selectedImageData != nil {
                    Spacer()
                    Button(role: .destructive) {
                        selectedImageData = nil
                        photoItem = nil
                    } label: {
                        Label("Remove", systemImage: "trash")
                    }
                }
            }
        } header: {
            Text("Photo")
        } footer: {
            Text("Optional. Shown on the recipe card and detail screen. Falls back to the icon below.")
        }
    }

    /// Downscales to at most 1200px on the long edge and re-encodes as JPEG to
    /// keep stored photos small.
    private func normalizedJPEG(from data: Data) -> Data? {
        guard let image = UIImage(data: data) else { return nil }
        let maxDim: CGFloat = 1200
        let longEdge = max(image.size.width, image.size.height)
        let scale = min(1, maxDim / longEdge)
        let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resized = renderer.image { _ in image.draw(in: CGRect(origin: .zero, size: newSize)) }
        return resized.jpegData(compressionQuality: 0.8)
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
            id: recipeToEdit?.id ?? UUID(),
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
                    timerSeconds: s.timerSeconds > 0 ? s.timerSeconds : nil
                )
            }
        )

        if let data = selectedImageData {
            UserRecipeImageStore.save(data, for: recipe.id)
        } else {
            UserRecipeImageStore.delete(for: recipe.id)
        }

        if recipeToEdit != nil {
            store.update(recipe)
        } else {
            store.add(recipe)
        }
        dismiss()
    }
}

// MARK: - Draft models

struct DraftIngredient: Identifiable {
    let id = UUID()
    var name: String
    var amount: String
    var unit: String

    init(name: String = "", amount: String = "", unit: String = "") {
        self.name = name
        self.amount = amount
        self.unit = unit
    }
}

struct DraftStep: Identifiable {
    let id = UUID()
    var order: Int
    var instruction: String
    var tip: String
    var timerSeconds: Int

    init(order: Int, instruction: String = "", tip: String = "", timerSeconds: Int = 0) {
        self.order = order
        self.instruction = instruction
        self.tip = tip
        self.timerSeconds = timerSeconds
    }
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
                    step.timerSeconds == 0 ? "No timer" : "Timer: \(Self.timerLabel(step.timerSeconds))",
                    value: $step.timerSeconds, in: 0...7200, step: 15
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.leading, 34)
        }
        .padding(.vertical, 4)
    }

    /// Formats seconds as "45 sec", "1 min", or "1 min 30 sec".
    static func timerLabel(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        switch (m, s) {
        case (0, _):  return "\(s) sec"
        case (_, 0):  return "\(m) min"
        default:      return "\(m) min \(s) sec"
        }
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
