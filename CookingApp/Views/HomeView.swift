import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: RecipeStore
    @EnvironmentObject var favorites: FavoritesStore
    @EnvironmentObject var auth: AuthManager
    @State private var searchText = ""
    @State private var selectedCuisine: String = "All"
    @State private var showFavoritesOnly = false
    @State private var showAddRecipe = false
    @State private var recipeToEdit: Recipe? = nil

    private var cuisineChips: [String] {
        let cuisines = store.allRecipes.map { $0.cuisine }
        let unique = Array(NSOrderedSet(array: cuisines)) as? [String] ?? []
        return ["All"] + unique.sorted()
    }

    var filteredRecipes: [Recipe] {
        store.allRecipes.filter { recipe in
            let matchesCuisine = selectedCuisine == "All" || recipe.cuisine == selectedCuisine
            let matchesSearch = searchText.isEmpty ||
                recipe.name.localizedCaseInsensitiveContains(searchText) ||
                recipe.searchableIngredients.contains { $0.name.localizedCaseInsensitiveContains(searchText) }
            let matchesFavorites = !showFavoritesOnly || favorites.isFavorite(recipe)
            return matchesCuisine && matchesSearch && matchesFavorites
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    header
                    searchBar
                    cuisineChipsRow
                    if filteredRecipes.isEmpty {
                        emptyState
                    }
                    ForEach(MealType.allCases, id: \.self) { mealType in
                        let recipes = filteredRecipes.filter { $0.mealType == mealType }
                        if !recipes.isEmpty {
                            sectionHeader("\(mealType.rawValue) (\(recipes.count))")
                            ForEach(recipes) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeCard(recipe: recipe, isUserRecipe: store.isUserRecipe(recipe), isFavorite: favorites.isFavorite(recipe))
                                }
                                .buttonStyle(.plain)
                                .contextMenu {
                                    if store.isUserRecipe(recipe) {
                                        Button {
                                            recipeToEdit = recipe
                                        } label: {
                                            Label("Edit Recipe", systemImage: "pencil")
                                        }
                                        Button(role: .destructive) {
                                            store.delete(recipe)
                                        } label: {
                                            Label("Delete Recipe", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .overlay(alignment: .bottomTrailing) {
                addButton
            }
            .sheet(isPresented: $showAddRecipe) {
                AddRecipeView()
            }
            .sheet(item: $recipeToEdit) { recipe in
                AddRecipeView(recipeToEdit: recipe)
            }
        }
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        let timeOfDay: String
        switch hour {
        case 5..<12:  timeOfDay = "Good morning"
        case 12..<17: timeOfDay = "Good afternoon"
        case 17..<21: timeOfDay = "Good evening"
        default:      timeOfDay = "Good night"
        }
        // Personalize with the signed-in user's first name (from Sign in with Apple).
        if let firstName = auth.displayName.split(separator: " ").first {
            return "\(timeOfDay), \(firstName)"
        }
        return timeOfDay
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 2) {
                Text(greeting)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 12)
                Text("What's cooking?")
                    .font(.system(size: 32, weight: .bold))
                    .tracking(-0.5)
            }
            Spacer()
            Button {
                withAnimation(.easeInOut(duration: 0.2)) { showFavoritesOnly.toggle() }
            } label: {
                Image(systemName: showFavoritesOnly ? "heart.fill" : "heart")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(showFavoritesOnly ? .red : .secondary)
                    .frame(width: 40, height: 40)
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.06), radius: 3, y: 1)
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Search recipes or ingredients", text: $searchText)
                .font(.subheadline)
            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color(uiColor: .systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var cuisineChipsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(cuisineChips, id: \.self) { chip in
                    Button { selectedCuisine = chip } label: {
                        Text(chip)
                            .font(.system(size: 13, weight: .medium))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(chip == selectedCuisine ? Color.primary : Color(uiColor: .systemBackground))
                            .foregroundStyle(chip == selectedCuisine ? Color(uiColor: .systemBackground) : Color.primary)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color(uiColor: .separator), lineWidth: 0.5))
                    }
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: showFavoritesOnly ? "heart.slash" : "magnifyingglass")
                .font(.system(size: 44, weight: .light))
                .foregroundStyle(.tertiary)
            Text(showFavoritesOnly ? "No favorites yet" : "No recipes found")
                .font(.system(size: 17, weight: .medium))
            Text(showFavoritesOnly
                 ? "Tap the heart on a recipe to save it here."
                 : "Try a different search or filter.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.system(size: 13, weight: .semibold))
            .tracking(0.8)
            .foregroundStyle(.secondary)
            .padding(.top, 4)
    }

    private var addButton: some View {
        Button { showAddRecipe = true } label: {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Color.primary)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
        }
        .padding(.trailing, 20)
        .padding(.bottom, 24)
    }
}

#Preview {
    HomeView()
        .environmentObject(RecipeStore())
        .environmentObject(FavoritesStore())
        .environmentObject(AuthManager())
}
