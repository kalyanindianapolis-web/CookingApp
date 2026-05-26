import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: RecipeStore
    @State private var searchText = ""
    @State private var selectedCuisine: String = "All"
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
                recipe.ingredients.contains { $0.name.localizedCaseInsensitiveContains(searchText) }
            return matchesCuisine && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    header
                    searchBar
                    cuisineChipsRow
                    ForEach(MealType.allCases, id: \.self) { mealType in
                        let recipes = filteredRecipes.filter { $0.mealType == mealType }
                        if !recipes.isEmpty {
                            sectionHeader("\(mealType.rawValue) (\(recipes.count))")
                            ForEach(recipes) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeCard(recipe: recipe, isUserRecipe: store.isUserRecipe(recipe))
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
        switch hour {
        case 5..<12: return "Good morning, Kalyan"
        case 12..<17: return "Good afternoon, Kalyan"
        case 17..<21: return "Good evening, Kalyan"
        default:      return "Good night, Kalyan"
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(greeting)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.top, 12)
            Text("What's cooking?")
                .font(.system(size: 32, weight: .bold))
                .tracking(-0.5)
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

#Preview { HomeView().environmentObject(RecipeStore()) }
