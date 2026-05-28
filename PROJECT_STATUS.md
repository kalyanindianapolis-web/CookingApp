# CookingApp — Project Status

**Platform:** iOS 17+, SwiftUI, Swift 5.9+, Xcode 16+  
**Repo:** https://github.com/kalyanindianapolis-web/CookingApp  
**Last updated:** 2026-05-26

---

## Architecture

| Layer | File | Purpose |
|-------|------|---------|
| Model | `Models/Recipe.swift` | `Recipe`, `RecipeVariation`, `Ingredient`, `Step`, `Difficulty`, `MealType` |
| Model | `Models/GroceryItem.swift` | `GroceryItem`, `GroceryCategory` |
| Model | `Models/MealPlan.swift` | `MealPlanEntry`, `MealSlotType` |
| Store | `Data/RecipeStore.swift` | Seed + user recipes; UserDefaults persistence |
| Store | `Data/GroceryStore.swift` | Grocery list; UserDefaults persistence |
| Store | `Data/MealPlanStore.swift` | Meal plan entries; UserDefaults persistence |
| Seed | `Data/SeedRecipes.swift` | All built-in recipes (static lets) |
| Views | `Views/HomeView.swift` | Tab 1 — recipe grid with search & filters |
| Views | `Views/RecipeDetailView.swift` | Recipe detail, variation picker, servings scaler |
| Views | `Views/IngredientCheckView.swift` | Pre-cook ingredient availability check |
| Views | `Views/CookingModeView.swift` | Step-by-step cooking mode with timers |
| Views | `Views/GroceryListView.swift` | Categorised grocery list |
| Views | `Views/MealPlanView.swift` | Weekly meal planner |
| Views | `Views/AddRecipeView.swift` | Add / edit custom recipes |
| Views | `Views/Components.swift` | Shared `RecipeCard`, `Color(hex:)` |

**UserDefaults keys:** `"groceryItems"`, `"userRecipes"`, `"mealPlanEntries"`

---

## Recipes (10 cards in Home)

### Lunch & Dinner (8)
| Card | Type | Variations |
|------|------|-----------|
| Dal Tadka | Standalone | — |
| Jeera Rice | Standalone | — |
| Bagara Rice | Standalone | — |
| Chana Masala | Standalone | — |
| Aloo Gobi | Standalone | — |
| Paneer Dahi Sandwich | Standalone | — |
| **Paneer** | Parent | Lababdar (base), Butter Masala, Chilli, Makhani Burger, Spicy Burger, Do Pyaaza, Palak, Kaju Masala |
| Rajma Masala | Standalone | — |

### Breakfast (2)
| Card | Type | Variations |
|------|------|-----------|
| **Chia Seed Pudding** | Parent | Base, Mango Coconut, Orange Creamsicle, Very Berry, Apple Pie, Pumpkin Spice, Chocolate Banana |
| Paneer Dahi Sandwich | Also shows in Breakfast | — |

---

## Features Built

### Core
- [x] Recipe list (Home) with search, cuisine filter, meal type filter
- [x] Recipe detail view with hero image, stats row, ingredients, steps
- [x] Servings scaler — auto-scales ingredient amounts with fraction display
- [x] Variation picker — horizontal chip row; swaps ingredients/steps/accent colour/photo
- [x] `baseLabel` support — grouped recipes can name their first chip (e.g. "Lababdar" not "Base")
- [x] Ingredient check view — shows which ingredients you have vs. missing; add missing to grocery list
- [x] Cooking mode — dark full-screen step-by-step view with per-step countdown timers
- [x] Grocery list — categorised, tap to check/uncheck, swipe to delete, clear checked items button
- [x] Meal planner — weekly calendar strip, assign breakfast/lunch/dinner per day, add day's ingredients to grocery
- [x] Add / edit custom recipes — name, icon, cuisine, difficulty, time, servings, accent colour, ingredients, steps with optional timer

### Photos
- [x] `imageName: String?` on both `Recipe` and `RecipeVariation` (optional, Codable backward-compatible)
- [x] All 9 recipe cards have real food photos from Unsplash (free license)
- [x] Each of the 8 Paneer variations has its own unique photo
- [x] Each of the 6 Chia Seed Pudding variations has its own unique photo
- [x] Tapping a variation chip swaps the hero photo as well as ingredients/steps
- [x] RecipeCard thumbnail shows the photo; falls back to SF Symbol icon for user-added recipes
- [x] Hero image falls back to gradient + SF Symbol when no photo is set

### UX Polish
- [x] Smart grocery category inference (`GroceryCategory.infer(from:)`)
- [x] Variation accent colour flows through: hero gradient, step numbers, timer text, Start Cooking button
- [x] Edit button visible only on user-added recipes (`store.isUserRecipe(recipe)`)
- [x] Keyboard Done button on decimal pad fields in AddRecipeView
- [x] Timer warning alert when navigating away from a running step timer
- [x] "You're all set!" success banner in IngredientCheckView when all ingredients are on list
- [x] "Added to grocery list" toast banner in MealPlanView after adding day's meals
- [x] "Clear checked" button in GroceryListView when checked items exist

---

## Bugs Fixed (Session — 2026-05-26)

| Priority | Bug | Fix |
|----------|-----|-----|
| Red | Swipe-to-delete in GroceryListView used a hardcoded workaround | Added `GroceryStore.delete(_ item:)` convenience method |
| Red | "Clear checked" had no UI entry point | Added conditional button below header in GroceryListView |
| Yellow | RecipeDetailView subtitle showed `recipe.totalMinutes` even when a variation was active | Changed to `effectiveRecipe.totalMinutes` |
| Yellow | MealPlanView gave no feedback after "Add day to grocery list" | Added animated green toast banner (2 sec) |
| Yellow | AddRecipeView decimal pad had no way to dismiss keyboard | Added `ToolbarItemGroup(placement: .keyboard)` Done button |
| Green | Re-editing a recipe truncated step timers (90 s → 1 min) | Switched integer division to `rounded()` |
| Green | CookingModeView silently reset timers on step navigation | Added alert: "Leave Step" or "Stay" |
| Green | IngredientCheckView had no success state | Added "You're all set!" banner when all ingredients are available |

---

## Photo Asset Map

All images are stored in `CookingApp/Assets.xcassets/` as `.imageset` folders. Free Unsplash licence.

### Standalone recipe cards
| Asset name | Recipe |
|---|---|
| `recipe_dal_tadka` | Dal Tadka |
| `recipe_jeera_rice` | Jeera Rice |
| `recipe_bagara_rice` | Bagara Rice |
| `recipe_chana_masala` | Chana Masala |
| `recipe_aloo_gobi` | Aloo Gobi |
| `recipe_paneer_sandwich` | Paneer Dahi Sandwich |
| `recipe_rajma` | Rajma Masala |
| `recipe_chia_pudding` | Chia Seed Pudding (base card) |

### Paneer variation photos (swap in when chip is tapped)
| Asset name | Variation |
|---|---|
| `recipe_paneer_lababdar` | Lababdar (base card + base chip) |
| `recipe_paneer_butter_masala` | Butter Masala |
| `recipe_paneer_chilli` | Chilli Paneer |
| `recipe_paneer_makhani_burger` | Makhani Burger |
| `recipe_paneer_spicy_burger` | Spicy Burger |
| `recipe_paneer_do_pyaaza` | Do Pyaaza |
| `recipe_palak_paneer` | Palak Paneer |
| `recipe_paneer_kaju_masala` | Kaju Masala |

### Chia Seed Pudding variation photos
| Asset name | Variation |
|---|---|
| `recipe_chia_base` | Base (plain chia, available as asset) |
| `recipe_chia_mango` | Mango Coconut |
| `recipe_chia_orange` | Orange Creamsicle |
| `recipe_chia_berry` | Very Berry |
| `recipe_chia_apple` | Apple Pie |
| `recipe_chia_pumpkin` | Pumpkin Spice |
| `recipe_chia_chocolate` | Chocolate Banana |

---

## Known Limitations / What's Left

### Recipes to add
- [ ] More breakfast options (oats, smoothies, parathas, idli/dosa)
- [ ] More standalone lunch/dinner dishes
- [ ] Snack / drinks category (currently only Breakfast and Lunch & Dinner exist in `MealType`)

### Features
- [ ] **Meal plan → variations**: when a parent recipe (Paneer, Chia) is added to a meal slot, there's no way to pick which variation you actually plan to cook — the slot just shows the parent recipe name
- [ ] **Grocery deduplication across meals**: if two recipes on the same day share an ingredient, quantities are not summed — only one entry is added (first-seen wins)
- [ ] **Recipe search by ingredient**: HomeView search checks ingredient names but only across the base recipe — not variations
- [ ] **Nutrition info**: no calorie or macro tracking
- [ ] **Share / export recipe**: no way to share a recipe card outside the app
- [ ] **Reorder ingredients / steps**: AddRecipeView has swipe-to-delete but no drag reorder
- [ ] **Step timer precision**: `DraftStep.timerMinutes` is whole minutes only; sub-minute timers (e.g. 90 s) round to nearest minute on edit
- [ ] **User recipe photos**: AddRecipeView has no photo picker — user-added recipes show SF Symbol fallback only

### Technical
- [ ] **Security**: GitHub remote URL contains an embedded PAT token — revoke at https://github.com/settings/tokens and run: `git remote set-url origin https://github.com/kalyanindianapolis-web/CookingApp.git`
- [ ] SourceKit false-positive diagnostics throughout (SourceKit indexer lag; all `xcodebuild` builds succeed — not a real issue)

---

## Data Model Notes

### `RecipeVariation` (Identifiable, Hashable, Codable)
```swift
id, name, accentHex, totalMinutes, ingredients: [Ingredient], steps: [Step], imageName: String?
```

### `Recipe` — key fields for photos and variations
```swift
var imageName: String?              // asset name in xcassets; nil = SF Symbol fallback
var variations: [RecipeVariation]?  // nil = no picker shown
var baseLabel: String?              // labels the first chip (default "Base")

func applying(_ variation: RecipeVariation) -> Recipe
// copies variation's imageName; falls back to parent's imageName if variation has none
```

### Codable backward compat
All new fields (`imageName`, `variations`, `baseLabel`) are optional — old UserDefaults JSON decodes fine (missing key → nil). No migration needed.

---

## Commit History (recent)
```
9420215  Add unique photos for each Paneer and Chia Seed Pudding variation
e278aa5  Add real food photos for all 9 recipe cards from Unsplash
0fa5cf2  Add PROJECT_STATUS.md with full feature inventory and what's left
7e0f730  Fix swipe-delete, clear-checked, timer warning, and UX polish
b16c52d  Add Paneer Kaju Masala as a paneer variation
06e31a9  Add Dhaba Style Rajma Masala recipe
a7771ae  Add Spicy Burger, Do Pyaaza, and Palak as paneer variations
4129822  Add Paneer Makhani Burger as a paneer variation
1deb13e  Group paneer dishes under one recipe with variations
c3204a7  Add Kaju Masala recipe
```
