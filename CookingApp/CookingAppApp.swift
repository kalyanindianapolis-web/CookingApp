import SwiftUI

@main
struct CookingAppApp: App {
    @StateObject private var store = RecipeStore()
    @StateObject private var groceryStore = GroceryStore()

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem { Label("Recipes", systemImage: "fork.knife") }
                GroceryListView()
                    .tabItem { Label("Groceries", systemImage: "cart") }
            }
            .environmentObject(store)
            .environmentObject(groceryStore)
        }
    }
}
