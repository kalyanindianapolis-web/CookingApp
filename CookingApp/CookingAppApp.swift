import SwiftUI

@main
struct CookingAppApp: App {
    @StateObject private var store = RecipeStore()
    @StateObject private var groceryStore = GroceryStore()
    @StateObject private var mealPlanStore = MealPlanStore()

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem { Label("Recipes", systemImage: "fork.knife") }
                MealPlanView()
                    .tabItem { Label("Meal Plan", systemImage: "calendar") }
                GroceryListView()
                    .tabItem { Label("Groceries", systemImage: "cart") }
            }
            .environmentObject(store)
            .environmentObject(groceryStore)
            .environmentObject(mealPlanStore)
        }
    }
}
