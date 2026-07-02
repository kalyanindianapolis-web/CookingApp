import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var servings: Int
    @State private var showIngredientCheck = false
    @State private var showEditRecipe = false
    @State private var selectedVariation: RecipeVariation? = nil
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var groceryStore: GroceryStore
    @EnvironmentObject var store: RecipeStore
    @EnvironmentObject var favorites: FavoritesStore

    init(recipe: Recipe) {
        self.recipe = recipe
        _servings = State(initialValue: recipe.defaultServings)
    }

    private var effectiveRecipe: Recipe {
        selectedVariation.map { recipe.applying($0) } ?? recipe
    }

    var scaledIngredients: [Ingredient] {
        effectiveRecipe.ingredients.map { $0.scaled(to: servings, from: recipe.defaultServings) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                heroImage
                VStack(alignment: .leading, spacing: 16) {
                    titleBlock
                    statsRow
                    if !(recipe.variations ?? []).isEmpty {
                        variationPicker
                    }
                    servingsControl
                    sectionHeader("Ingredients")
                    ingredientsList
                    sectionHeader("Steps")
                    stepsList
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .safeAreaInset(edge: .bottom, spacing: 0) {
            startCookingButton
                .background(.ultraThinMaterial)
        }
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) { backButton }
        .overlay(alignment: .topTrailing) {
            HStack(spacing: 8) {
                favoriteButton
                if store.isUserRecipe(recipe) { editButton }
            }
            .padding(.trailing, 16).padding(.top, 12)
        }
        .sheet(isPresented: $showIngredientCheck) {
            IngredientCheckView(recipe: effectiveRecipe)
                .environmentObject(groceryStore)
        }
        .sheet(isPresented: $showEditRecipe) {
            AddRecipeView(recipeToEdit: recipe)
                .environmentObject(store)
        }
    }

    private var heroImage: some View {
        ZStack {
            if let imageName = effectiveRecipe.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                heroScrim
            } else if let uiImage = UserRecipeImageStore.image(for: effectiveRecipe.id) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                heroScrim
            } else {
                LinearGradient(
                    colors: [Color(hex: effectiveRecipe.accentHex), Color(hex: effectiveRecipe.accentHex).opacity(0.7)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                Image(systemName: recipe.sfSymbol)
                    .font(.system(size: 72, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .frame(height: 220)
        .clipped()
    }

    private var heroScrim: some View {
        LinearGradient(
            colors: [.black.opacity(0.35), .clear],
            startPoint: .bottom, endPoint: .center
        )
    }

    private var backButton: some View {
        Button { dismiss() } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(width: 36, height: 36)
                .background(.white.opacity(0.92))
                .clipShape(Circle())
        }
        .padding(.leading, 16).padding(.top, 12)
    }

    private var editButton: some View {
        Button { showEditRecipe = true } label: {
            Image(systemName: "pencil")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(width: 36, height: 36)
                .background(.white.opacity(0.92))
                .clipShape(Circle())
        }
    }

    private var favoriteButton: some View {
        Button {
            withAnimation(.spring(duration: 0.3)) { favorites.toggle(recipe) }
        } label: {
            Image(systemName: favorites.isFavorite(recipe) ? "heart.fill" : "heart")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(favorites.isFavorite(recipe) ? .red : .primary)
                .frame(width: 36, height: 36)
                .background(.white.opacity(0.92))
                .clipShape(Circle())
        }
    }

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(recipe.name)
                .font(.system(size: 24, weight: .bold))
                .tracking(-0.5)
            Text("\(recipe.cuisine) · \(recipe.difficulty.rawValue) · \(effectiveRecipe.totalMinutes) min total")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private var statsRow: some View {
        HStack(spacing: 10) {
            statCard(value: "\(effectiveRecipe.totalMinutes)m", label: "Time")
            statCard(value: "\(effectiveRecipe.steps.count)", label: "Steps")
            statCard(value: recipe.isMultiDish ? "Multi" : "Solo", label: "Dishes")
        }
    }

    private func statCard(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value).font(.system(size: 16, weight: .bold))
            Text(label.uppercased())
                .font(.system(size: 10, weight: .medium))
                .tracking(0.5)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var servingsControl: some View {
        HStack {
            Text("Servings · auto-scales")
                .font(.subheadline.weight(.medium))
            Spacer()
            HStack(spacing: 10) {
                stepperBtn(symbol: "minus") {
                    if servings > 1 { servings -= 1 }
                }
                Text("\(servings)")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(minWidth: 20)
                stepperBtn(symbol: "plus") {
                    if servings < 20 { servings += 1 }
                }
            }
            .padding(.horizontal, 6).padding(.vertical, 3)
            .background(Color(uiColor: .systemGray5))
            .clipShape(Capsule())
        }
        .padding(.horizontal, 14).padding(.vertical, 10)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func stepperBtn(symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 12, weight: .bold))
                .frame(width: 22, height: 22)
                .background(Color(uiColor: .systemBackground))
                .clipShape(Circle())
        }
    }

    private var ingredientsList: some View {
        VStack(spacing: 0) {
            ForEach(Array(scaledIngredients.enumerated()), id: \.element.id) { index, ing in
                HStack {
                    Text(ing.name).font(.footnote)
                    Spacer()
                    Text(ing.displayAmount)
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 9)
                if index < scaledIngredients.count - 1 {
                    Divider()
                }
            }
        }
        .padding(.horizontal, 14)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var stepsList: some View {
        VStack(spacing: 8) {
            ForEach(effectiveRecipe.steps) { step in
                HStack(alignment: .top, spacing: 12) {
                    Text("\(step.order)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                        .background(Color(hex: effectiveRecipe.accentHex))
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 4) {
                        Text(step.instruction).font(.footnote)
                        if let tip = step.tip {
                            Text("💡 \(tip)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        if let secs = step.timerSeconds {
                            Label("\(secs / 60) min timer", systemImage: "timer")
                                .font(.caption)
                                .foregroundStyle(Color(hex: effectiveRecipe.accentHex))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.system(size: 13, weight: .semibold))
            .tracking(0.8)
            .foregroundStyle(.secondary)
            .padding(.top, 4)
    }

    private var startCookingButton: some View {
        Button { showIngredientCheck = true } label: {
            Text("Start Cooking →")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(14)
                .background(Color(hex: effectiveRecipe.accentHex))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: Color(hex: effectiveRecipe.accentHex).opacity(0.35), radius: 12, y: 6)
        }
        .padding(.horizontal, 20).padding(.bottom, 24)
    }

    private var variationPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                chip(label: recipe.baseLabel ?? "Base", isSelected: selectedVariation == nil) {
                    selectedVariation = nil
                }
                ForEach(recipe.variations ?? []) { variation in
                    chip(label: variation.name, isSelected: selectedVariation?.id == variation.id) {
                        selectedVariation = variation
                    }
                }
            }
        }
    }

    private func chip(label: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? Color.primary : Color(uiColor: .systemGray5))
                .foregroundStyle(isSelected ? Color(uiColor: .systemBackground) : Color.primary)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    NavigationStack { RecipeDetailView(recipe: SeedRecipes.dalTadka) }
        .environmentObject(RecipeStore())
        .environmentObject(GroceryStore())
        .environmentObject(FavoritesStore())
}
