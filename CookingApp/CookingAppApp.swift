import SwiftUI
import CloudKit

@main
struct CookingAppApp: App {
    @StateObject private var store = RecipeStore()
    @StateObject private var groceryStore = GroceryStore()
    @StateObject private var mealPlanStore = MealPlanStore()
    @StateObject private var auth = AuthManager()
    @StateObject private var sharing = SharingManager()

    init() {
        PersistenceController.shared.migrateLegacyDataIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            rootView
        }
    }

    @ViewBuilder
    private var rootView: some View {
        if auth.isSignedIn {
            mainTabView
                .onOpenURL { url in
                    sharing.acceptShare(url: url)
                }
        } else {
            AuthView()
                .environmentObject(auth)
        }
    }

    private var mainTabView: some View {
        TabView {
            HomeView()
                .tabItem { Label("Recipes", systemImage: "fork.knife") }
            MealPlanView()
                .tabItem { Label("Meal Plan", systemImage: "calendar") }
            GroceryListView()
                .tabItem { Label("Groceries", systemImage: "cart") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
        .environmentObject(store)
        .environmentObject(groceryStore)
        .environmentObject(mealPlanStore)
        .environmentObject(auth)
        .environmentObject(sharing)
    }
}
