import SwiftUI

// MARK: - Shared color utility

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

// MARK: - Recipe card (used in HomeView and RecipePickerSheet)

struct RecipeCard: View {
    let recipe: Recipe
    var isUserRecipe: Bool = false

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                if let imageName = recipe.imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color(hex: recipe.accentHex).opacity(0.15)
                    Image(systemName: recipe.sfSymbol)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(Color(hex: recipe.accentHex))
                }
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
