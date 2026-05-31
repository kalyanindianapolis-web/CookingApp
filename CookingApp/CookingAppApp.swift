import SwiftUI
import CloudKit

@main
struct CookingAppApp: App {
    @StateObject private var store = RecipeStore()
    @StateObject private var groceryStore = GroceryStore()
    @StateObject private var mealPlanStore = MealPlanStore()
    @StateObject private var auth = AuthManager()
    @StateObject private var sharing = SharingManager()
    @StateObject private var remoteLoader = RemoteRecipeLoader()

    @Environment(\.scenePhase) private var scenePhase

    init() {
        PersistenceController.shared.migrateLegacyDataIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            rootView
                // Push remote recipes into RecipeStore whenever the loader updates
                .onChange(of: remoteLoader.recipes) { _, recipes in
                    store.updateRemoteRecipes(recipes)
                }
                // Re-fetch every time the app comes to the foreground
                .onChange(of: scenePhase) { _, phase in
                    if phase == .active {
                        remoteLoader.fetchIfReachable()
                    }
                }
        }
    }

    @ViewBuilder
    private var rootView: some View {
        #if targetEnvironment(simulator)
        mainTabView
            .onOpenURL { url in sharing.acceptShare(url: url) }
        #else
        if auth.isSignedIn {
            mainTabView
                .onOpenURL { url in sharing.acceptShare(url: url) }
        } else {
            AuthView()
                .environmentObject(auth)
        }
        #endif
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
        .environmentObject(remoteLoader)
    }
}
