import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: RecipeStore
    @State private var searchText = ""
    @State private var selectedCuisine: String = "All"
    @State private var showAddRecipe = false

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
                    sectionHeader("Recipes (\(filteredRecipes.count))")
                    ForEach(filteredRecipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCard(recipe: recipe, isUserRecipe: store.isUserRecipe(recipe))
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            if store.isUserRecipe(recipe) {
                                Button(role: .destructive) {
                                    store.delete(recipe)
                                } label: {
                                    Label("Delete Recipe", systemImage: "trash")
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
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Good evening, Kalyan")
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

// MARK: - RecipeCard

struct RecipeCard: View {
    let recipe: Recipe
    var isUserRecipe: Bool = false

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Color(hex: recipe.accentHex).opacity(0.15)
                Image(systemName: recipe.sfSymbol)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundStyle(Color(hex: recipe.accentHex))
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(recipe.name)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.primary)
                    if isUserRecipe {
                        Text("MY RECIPE")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5).padding(.vertical, 2)
                            .background(Color.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                HStack(spacing: 10) {
                    Label("\(recipe.totalMinutes) min", systemImage: "clock")
                    Label("\(recipe.defaultServings)", systemImage: "person.2")
                    Label(recipe.difficulty.rawValue, systemImage: "chart.bar")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                if recipe.isMultiDish {
                    Text("◉ MULTI-DISH")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color(hex: "FF6B35"))
                        .padding(.horizontal, 7).padding(.vertical, 2)
                        .background(Color(hex: "FF6B35").opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .padding(.top, 2)
                }
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 3, y: 1)
    }
}

// MARK: - Color hex extension

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: s).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xFF) / 255
        let g = Double((v >> 8) & 0xFF) / 255
        let b = Double(v & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

#Preview { HomeView().environmentObject(RecipeStore()) }
