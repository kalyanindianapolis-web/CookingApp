import SwiftUI

struct IngredientCheckView: View {
    let recipe: Recipe
    @EnvironmentObject var groceryStore: GroceryStore
    @Environment(\.dismiss) private var dismiss
    @State private var showCookingMode = false

    private var available: [Ingredient] {
        recipe.ingredients.filter { isAvailable($0) }
    }

    private var missing: [Ingredient] {
        recipe.ingredients.filter { !isAvailable($0) }
    }

    private func isAvailable(_ ingredient: Ingredient) -> Bool {
        let target = ingredient.groceryName.lowercased()
        return groceryStore.items.contains {
            let listed = $0.name.lowercased()
            return listed.contains(target) || target.contains(listed)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    summaryBanner

                    if missing.isEmpty && !recipe.ingredients.isEmpty {
                        successBanner
                    }

                    if !available.isEmpty {
                        ingredientSection(
                            title: "✅ You have it",
                            subtitle: "These are on your grocery list",
                            items: available,
                            tint: .green
                        )
                    }

                    if !missing.isEmpty {
                        ingredientSection(
                            title: "❌ Not on your list",
                            subtitle: "These are missing from your grocery list",
                            items: missing,
                            tint: .red
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 120)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Ingredients Check")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back") { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                bottomButtons
                    .background(.ultraThinMaterial)
            }
            .fullScreenCover(isPresented: $showCookingMode) {
                CookingModeView(recipe: recipe)
                    .environmentObject(groceryStore)
            }
        }
    }

    private var successBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 28))
                .foregroundStyle(.green)
            VStack(alignment: .leading, spacing: 2) {
                Text("You're all set!")
                    .font(.system(size: 15, weight: .semibold))
                Text("All ingredients are on your grocery list")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.green.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    private var summaryBanner: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.system(size: 17, weight: .bold))
                Text("\(available.count) of \(recipe.ingredients.count) ingredients available")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            ZStack {
                Circle()
                    .stroke(Color(uiColor: .systemGray5), lineWidth: 4)
                    .frame(width: 52, height: 52)
                Circle()
                    .trim(from: 0, to: recipe.ingredients.isEmpty ? 0 : CGFloat(available.count) / CGFloat(recipe.ingredients.count))
                    .stroke(available.count == recipe.ingredients.count ? Color.green : Color.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 52, height: 52)
                    .rotationEffect(.degrees(-90))
                Text("\(available.count)/\(recipe.ingredients.count)")
                    .font(.system(size: 11, weight: .bold))
            }
        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.top, 16)
    }

    private func ingredientSection(title: String, subtitle: String, items: [Ingredient], tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            VStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, ing in
                    HStack {
                        Circle()
                            .fill(tint.opacity(0.15))
                            .frame(width: 8, height: 8)
                        Text(ing.name)
                            .font(.system(size: 15))
                        Spacer()
                        Text(ing.displayAmount)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    if index < items.count - 1 {
                        Divider().padding(.leading, 30)
                    }
                }
            }
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var bottomButtons: some View {
        VStack(spacing: 10) {
            if !missing.isEmpty {
                Button {
                    for ing in missing {
                        groceryStore.add(name: ing.groceryName, quantity: ing.displayAmount, category: GroceryCategory.infer(from: ing.groceryName))
                    }
                    dismiss()
                } label: {
                    Text("Add \(missing.count) missing item\(missing.count == 1 ? "" : "s") to list")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Color(uiColor: .systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            Button {
                showCookingMode = true
            } label: {
                Text("Start Cooking →")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(14)
                    .background(Color(hex: recipe.accentHex))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: Color(hex: recipe.accentHex).opacity(0.35), radius: 12, y: 6)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
        .padding(.top, 12)
    }
}

#Preview {
    IngredientCheckView(recipe: SeedRecipes.dalTadka)
        .environmentObject(GroceryStore())
}
