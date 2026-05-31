# CookingApp — Project Status

**Platform:** iOS 17+, SwiftUI, Swift 5.9+, Xcode 16+
**Repo:** https://github.com/kalyanindianapolis-web/CookingApp
**Home Assistant:** http://192.168.86.102:8123
**Last updated:** 2026-05-30

> See [[CookingApp-Obsidian]] for the full architectural overview with Mermaid diagrams.

---

## Architecture

| Layer | File | Purpose |
|-------|------|---------|
| Model | `Models/Recipe.swift` | `Recipe`, `RecipeVariation`, `Ingredient`, `Step`, `Difficulty`, `MealType` |
| Model | `Models/GroceryItem.swift` | `GroceryItem`, `GroceryCategory` |
| Model | `Models/MealPlan.swift` | `MealPlanEntry`, `MealSlotType` |
| Store | `Data/RecipeStore.swift` | Seed + remote + user recipes; Core Data |
| Store | `Data/GroceryStore.swift` | Grocery list; Core Data |
| Store | `Data/MealPlanStore.swift` | Meal plan entries; Core Data |
| Store | `Data/PersistenceController.swift` | NSPersistentCloudKitContainer + migration |
| Store | `Data/AuthManager.swift` | Sign in with Apple state |
| Store | `Data/SharingManager.swift` | CloudKit CKShare household |
| Store | `Data/RemoteRecipeLoader.swift` | **HA recipe fetch + cache** |
| Seed | `Data/SeedRecipes.swift` | All built-in recipes (static lets) |
| Views | `Views/HomeView.swift` | Tab 1 — recipe grid with search & filters |
| Views | `Views/RecipeDetailView.swift` | Recipe detail, variation picker, servings scaler |
| Views | `Views/IngredientCheckView.swift` | Pre-cook ingredient availability check |
| Views | `Views/CookingModeView.swift` | Step-by-step cooking mode with timers |
| Views | `Views/GroceryListView.swift` | Categorised grocery list |
| Views | `Views/MealPlanView.swift` | Weekly meal planner |
| Views | `Views/AddRecipeView.swift` | Add / edit custom recipes |
| Views | `Views/AuthView.swift` | Sign in with Apple gate |
| Views | `Views/SettingsView.swift` | Account, household, **HA URL config** |
| Views | `Views/Components.swift` | Shared `RecipeCard`, `Color(hex:)` |
| Root | `CookingAppApp.swift` | Entry point, TabView, scenePhase hook |
| Root | `CookingApp.xcdatamodeld` | 3 Core Data entities |
| Root | `Info.plist` | Local network permissions for HA |

**Persistence stack:** Core Data + iCloud sync (when entitlement set) · UserDefaults for auth + HA cache.

**UserDefaults keys:** `siwa_userID`, `siwa_displayName`, `ha_recipe_url`, `ha_remote_recipes_cache`

---

## Recipes (16 cards in Home)

### Breakfast (3)
| Card | Type | Variations |
|------|------|-----------|
| Paneer Dahi Sandwich | Standalone | — |
| **Chia Seed Pudding** | Parent | Base, Mango Coconut, Orange Creamsicle, Very Berry, Apple Pie, Pumpkin Spice, Chocolate Banana |
| Chilli Cheese Corn Sandwich | Standalone | — |

### Lunch & Dinner (13)
| Card | Type | Variations |
|------|------|-----------|
| Dal Tadka | Standalone | — |
| Jeera Rice | Standalone | — |
| Bagara Rice | Standalone | — |
| Chana Masala | Standalone | — |
| Aloo Gobi | Standalone | — |
| **Paneer** | Parent | Lababdar (base), Butter Masala, Chilli, Makhani Burger, Spicy Burger, Do Pyaaza, Palak, Kaju Masala |
| Kaju Masala | Standalone | — |
| Rajma Masala | Standalone | — |
| Pani Puri Pani | Standalone | — |
| Masala Puri | Standalone | — |
| Phuchka & Churmur | Multi-dish | — |
| Thecha Paneer Rice | Standalone | — |
| Paneer Hot Garlic Sauce & Fried Rice | Multi-dish | — |

**Plus unlimited recipes via Home Assistant** — add to `/config/www/recipes.json`.

---

## Features Built

### Core
- [x] Recipe grid with search (name + ingredient), cuisine filter
- [x] Recipe detail with hero image, stats, ingredients, steps
- [x] Servings scaler with smart fraction display
- [x] Variation picker — swaps ingredients, steps, accent, hero photo
- [x] `baseLabel` support for parent recipes
- [x] Ingredient check view with add-to-grocery
- [x] Cooking mode — dark full-screen, per-step countdown timers
- [x] Grocery list — categorised, tap check, swipe delete, clear checked
- [x] Meal planner — weekly calendar, add day to grocery
- [x] Add / edit custom recipes — full form

### Photos
- [x] `imageName: String?` on Recipe and RecipeVariation (Codable backward-compat)
- [x] Real food photos for all 9 standalone recipe cards (Unsplash)
- [x] Unique photo per Paneer variation (8 photos)
- [x] Unique photo per Chia variation (7 photos)
- [x] Tapping a variation chip swaps the hero photo
- [x] RecipeCard thumbnail shows the photo; SF Symbol fallback for user recipes
- [x] Hero falls back to gradient + SF Symbol when no photo

### Login & Sync
- [x] Sign in with Apple gate (auto-bypassed on simulator)
- [x] Core Data replaces UserDefaults; one-time migration on first launch
- [x] NSPersistentCloudKitContainer — silent iCloud sync when entitlement set
- [x] CloudKit guards — app doesn't crash without entitlement
- [x] Household sharing via CKShare → UICloudSharingController
- [x] Settings tab with account, household, sign out

### 🏠 Home Assistant (NEW)
- [x] `RemoteRecipeLoader` fetches `recipes.json` from HA on launch + foreground
- [x] Default URL: `http://homeassistant.local:8123/local/recipes.json`
- [x] Configurable URL in Settings
- [x] 5-second timeout — fails silently when away from home
- [x] UserDefaults cache so recipes persist offline
- [x] Deduplicated stable UUIDs derived from recipe name
- [x] `Info.plist` allows HTTP to local network + Bonjour discovery
- [x] HA template JSON in `MD files/HA-recipes-template.json`

### UX Polish
- [x] Smart grocery category inference (`GroceryCategory.infer(from:)`)
- [x] Variation accent colour flows through hero, step numbers, timer, button
- [x] Edit button visible only on user recipes
- [x] Keyboard Done button on decimal pads
- [x] Timer warning when leaving a running step
- [x] "You're all set!" success banner in IngredientCheckView
- [x] "Added to grocery list" toast in MealPlanView
- [x] "Clear checked" button in GroceryListView

---

## Bugs Fixed

| Priority | Bug | Fix | Commit |
|----------|-----|-----|--------|
| 🔴 Red | App showed blank screen on launch (NSPersistentCloudKitContainer NSException) | Added `cloudKitEnabled` runtime check, guards all CloudKit calls | `e3e47ed` |
| 🔴 Red | App crashed without iCloud entitlement configured | Fall back to plain `NSPersistentContainer` when entitlement missing | `aab1ee3` |
| 🔴 Red | Swipe-to-delete in GroceryListView used hardcoded workaround | Added `GroceryStore.delete(_ item:)` convenience method | `7e0f730` |
| 🔴 Red | "Clear checked" had no UI entry point | Added conditional button below header in GroceryListView | `7e0f730` |
| 🟡 Yellow | RecipeDetailView subtitle showed wrong totalMinutes for variations | Changed to `effectiveRecipe.totalMinutes` | `7e0f730` |
| 🟡 Yellow | Hero image didn't swap when picking variation | Changed to `effectiveRecipe.imageName` | (later session) |
| 🟡 Yellow | MealPlanView gave no feedback after add-to-grocery | Added animated green toast banner | `7e0f730` |
| 🟡 Yellow | AddRecipeView decimal pad had no dismiss keyboard | Added `ToolbarItemGroup(placement: .keyboard)` Done | `7e0f730` |
| 🟢 Green | Re-editing recipe truncated step timers (90s → 1min) | Switched integer division to `rounded()` | `7e0f730` |
| 🟢 Green | CookingModeView silently reset timers on step navigation | Added "Leave Step" / "Stay" alert | `7e0f730` |
| 🟢 Green | IngredientCheckView had no success state | Added "You're all set!" banner | `7e0f730` |

---

## Home Assistant Setup (One-Time)

The HA instance is at **`http://192.168.86.102:8123`**. The recipe JSON is served at **`/local/recipes.json`**.

**To add a new recipe:**
1. Open HA Terminal addon (or File Editor)
2. Edit `/config/www/recipes.json`
3. Add an object using the schema in `MD files/HA-recipes-template.json`
4. Save → next app launch on home WiFi picks it up

**No code change, no new app version, no App Store re-submission.**

---

## Known Limitations / What's Left

### Recipes to add
- [ ] More breakfast options (oats, parathas, idli/dosa, smoothies)
- [ ] Snacks / drinks category (no MealType for it yet)

### Features
- [ ] **Meal plan → variations**: can't pick which Paneer/Chia variation when adding to a meal slot
- [ ] **Grocery deduplication across meals**: same ingredient on two recipes isn't summed
- [ ] **Recipe search by ingredient**: HomeView search checks ingredients but only on base recipe, not variations
- [ ] **Nutrition info**: no calorie or macro tracking
- [ ] **Share / export recipe**: no recipe card export
- [ ] **Reorder ingredients / steps**: AddRecipeView has swipe-delete but no drag reorder
- [ ] **Step timer precision**: `DraftStep.timerMinutes` is whole minutes only; sub-minute timers round on edit
- [ ] **User recipe photos**: AddRecipeView has no photo picker
- [ ] **HA recipe photos**: JSON can name an asset but no remote image download

### Technical
- [ ] **iCloud entitlements**: must be added manually in Xcode → Signing & Capabilities
- [ ] **HA remote access**: works only on home WiFi unless you expose HA via Nabu Casa or VPN
- [ ] **Security**: GitHub remote URL contains an embedded PAT token — revoke at https://github.com/settings/tokens
- [ ] SourceKit false-positive diagnostics throughout (indexer lag — all `xcodebuild` builds succeed)

---

## Data Model Notes

### `RecipeVariation` (Identifiable, Hashable, Codable)
```swift
id, name, accentHex, totalMinutes, ingredients: [Ingredient], steps: [Step], imageName: String?
```

### `Recipe` — key fields
```swift
var imageName: String?              // asset name; nil = SF Symbol fallback
var variations: [RecipeVariation]?  // nil = no picker shown
var baseLabel: String?              // labels the first chip (default "Base")

func applying(_ variation: RecipeVariation) -> Recipe
// copies variation's imageName; falls back to parent's imageName if variation has none
```

### Codable backward compat
All optional fields (`imageName`, `variations`, `baseLabel`) decode as nil when missing — old user JSON in UserDefaults migrates cleanly to Core Data.

### Stable UUIDs for HA recipes
Same recipe name always produces the same UUID (`ha:<name>` hash) — no duplicates on re-fetch.

---

## Commit History (recent)
```
d73dc88  Add Home Assistant remote recipe loading
ff20f7f  Move all MD files into MD files/ folder (Obsidian vault)
641a31f  Add Obsidian project overview with Mermaid diagrams
2ecda5e  Add Veg Chilli Cheese Corn Sandwich recipe
ccadce9  Add Paneer Hot Garlic Sauce & Burnt Chilli Garlic Fried Rice
7864fcc  Add Phuchka & Churmur and Thecha Paneer Rice recipes
66cd1b1  Add Masala Puri recipe
e834d06  Add Pani Puri Pani recipe
e3e47ed  Fix crash on launch: guard all CloudKit API calls
aab1ee3  Fix blank screen: fall back to NSPersistentContainer
c8c9a35  Add Sign in with Apple, Core Data persistence, CloudKit sharing
9420215  Add unique photos for each Paneer and Chia variation
e278aa5  Add real food photos for all 9 recipe cards from Unsplash
```
