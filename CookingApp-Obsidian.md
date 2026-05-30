# 🍳 CookingApp

> **Personal iOS recipe app** — plan meals, cook step-by-step, share your grocery list with your household, and build your own recipe collection.

---

## 📋 Summary

CookingApp is a native **SwiftUI iOS 17+** app built for Kalyan and his household. It replaces scattered recipe bookmarks and WhatsApp grocery lists with a single app that ties together recipes, weekly meal planning, a shared grocery list, and step-by-step cooking mode with per-step timers.

The app is fully **offline-first** — all data lives in Core Data on-device. When iCloud entitlements are configured, it syncs automatically in the background via **NSPersistentCloudKitContainer**. Household sharing works through **CloudKit CKShare**, so both phones stay in sync in real time without any manual export.

> [!info] Repo & Platform
> **GitHub:** https://github.com/kalyanindianapolis-web/CookingApp
> **Platform:** iOS 17+ · SwiftUI · Swift 5.9+ · Xcode 16+
> **Last updated:** 2026-05-30

---

## 🏗️ Architecture

```mermaid
flowchart TD
    subgraph App["📱 App Layer"]
        direction TB
        AV[AuthView\nSign in with Apple]
        TV[TabView\n4 tabs]
    end

    subgraph Views["🖼️ Views"]
        direction LR
        HV[HomeView]
        RDV[RecipeDetailView]
        ICV[IngredientCheckView]
        CMV[CookingModeView]
        MPV[MealPlanView]
        GLV[GroceryListView]
        ARV[AddRecipeView]
        SV[SettingsView]
    end

    subgraph Stores["🗃️ Stores  — ObservableObject"]
        direction LR
        RS[RecipeStore]
        GS[GroceryStore]
        MPS[MealPlanStore]
        AM[AuthManager]
        SM[SharingManager]
    end

    subgraph Persistence["💾 Persistence"]
        PC[PersistenceController]
        CD[(Core Data\nSQLite)]
        UD[(UserDefaults\nAuth token)]
        SR[SeedRecipes\nStatic lets]
    end

    subgraph Cloud["☁️ Cloud"]
        CK[iCloud\nCloudKit]
        SIWA[Apple ID\nSign in with Apple]
    end

    App --> Views
    Views --> Stores
    Stores --> PC
    PC --> CD
    CD <-->|Sync when entitlement set| CK
    AM --> UD
    AM --> SIWA
    SM --> CK
    RS --> SR
```

---

## 📱 Navigation Flow

```mermaid
flowchart TD
    Launch([🚀 App Launch]) --> Check{Signed in?\nor Simulator?}

    Check -->|No| Auth[AuthView\n— Sign in with Apple —]
    Check -->|Yes| Tabs

    Auth -->|✅ Signed in| Tabs[TabView]

    Tabs --> T1[🍽️ Recipes\nHomeView]
    Tabs --> T2[📅 Meal Plan\nMealPlanView]
    Tabs --> T3[🛒 Groceries\nGroceryListView]
    Tabs --> T4[⚙️ Settings\nSettingsView]

    T1 -->|Tap card| RDV[RecipeDetailView\nHero photo · Stats · Variations\nIngredients · Steps]
    RDV -->|Start Cooking →| ICV[IngredientCheckView\nHave vs. missing]
    ICV -->|Start Cooking →| CMV[CookingModeView\nDark full-screen\nPer-step timers]
    RDV -->|✏️ Edit| ARV[AddRecipeView\nEdit custom recipe]
    T1 -->|＋ button| ARV2[AddRecipeView\nNew custom recipe]

    T2 -->|Tap slot| Sheet[Recipe Picker Sheet]
    Sheet -->|Select| T2
    T2 -->|Add day to grocery| T3

    T4 -->|Share Household| CKShare[UICloudSharingController\niCloud invite link]
```

---

## 🗂️ Data Model

```mermaid
erDiagram
    RECIPE {
        UUID id
        String name
        String cuisine
        Difficulty difficulty
        Int totalMinutes
        Int defaultServings
        String sfSymbol
        String accentHex
        Bool isMultiDish
        MealType mealType
        String imageName
        String baseLabel
    }
    RECIPE_VARIATION {
        UUID id
        String name
        String accentHex
        Int totalMinutes
        String imageName
    }
    INGREDIENT {
        UUID id
        String name
        Double amount
        String unit
    }
    STEP {
        UUID id
        Int order
        String instruction
        String tip
        Int timerSeconds
    }
    GROCERY_ITEM {
        UUID id
        String name
        String quantity
        Bool isChecked
        GroceryCategory category
    }
    MEAL_PLAN_ENTRY {
        UUID id
        Date date
        MealSlotType slot
        UUID recipeId
        String recipeName
        String accentHex
    }

    RECIPE ||--o{ INGREDIENT : contains
    RECIPE ||--o{ STEP : contains
    RECIPE ||--o{ RECIPE_VARIATION : "has variations"
    RECIPE_VARIATION ||--o{ INGREDIENT : overrides
    RECIPE_VARIATION ||--o{ STEP : overrides
```

> [!note] Storage
> - **Seed recipes** (built-in) → static Swift lets in `SeedRecipes.swift`. Never stored in Core Data.
> - **User recipes** → `RecipeEntity` in Core Data (JSON blob per recipe).
> - **Grocery items** → `GroceryItemEntity` — individual attributes, syncs item-by-item.
> - **Meal plan entries** → `MealPlanEntryEntity` — individual attributes, syncs entry-by-entry.

---

## ☁️ Login & Household Sharing

```mermaid
sequenceDiagram
    actor Kalyan
    actor Wife
    participant App
    participant Apple
    participant iCloud

    Kalyan->>App: Launch app
    App->>Apple: getCredentialState(userID)
    Apple-->>App: .notFound (first launch)
    App->>Kalyan: Show Sign in with Apple

    Kalyan->>Apple: Tap "Sign in with Apple"
    Apple-->>App: ASAuthorizationAppleIDCredential
    App->>App: Save userID to UserDefaults
    App->>Kalyan: Show main TabView

    Note over App,iCloud: Core Data syncs silently in background
    App-->iCloud: NSPersistentCloudKitContainer auto-sync

    Kalyan->>App: Settings → Share Household
    App->>iCloud: Create CKShare
    iCloud-->>Kalyan: Share link
    Kalyan->>Wife: Send link (iMessage / WhatsApp)

    Wife->>App: Open link → Accept
    App->>iCloud: acceptShareInvitations()
    iCloud-->>Wife: Sync shared zone
    Note over Kalyan,Wife: Meal plan & grocery list now live-sync ✅
```

> [!warning] iCloud Setup Required
> To activate sync and sharing, add these in Xcode → Target → Signing & Capabilities:
> 1. **iCloud** → enable CloudKit → create container `iCloud.com.kalyan.CookingApp`
> 2. **Sign in with Apple**
>
> Without these, the app runs fully offline (local Core Data only) and the simulator bypasses the login gate automatically.

---

## 📚 Recipe Library  

**16 recipe cards** · **14 variations** across 2 parent recipes

### 🍳 Breakfast (3 cards)

| Recipe | Difficulty | Time | Notes |
|--------|-----------|------|-------|
| Paneer Dahi Sandwich | Easy | 35 min | Classic |
| **Chia Seed Pudding** | Easy | 125 min | 6 flavour variations |
| Chilli Cheese Corn Sandwich | Easy | 20 min | Triple-decker, streety chutney |

**Chia variations:** Base · Mango Coconut · Orange Creamsicle · Very Berry · Apple Pie · Pumpkin Spice · Chocolate Banana

---

### 🍽️ Lunch & Dinner (13 cards)

| Recipe | Cuisine | Difficulty | Time | Notes |
|--------|---------|-----------|------|-------|
| Dal Tadka | North Indian | Medium | 45 min | Two-tadka dhaba style |
| Jeera Rice | North Indian | Easy | 20 min | Wok-tossed |
| Bagara Rice | Hyderabadi | Easy | 65 min | Whole-spice basmati |
| Chana Masala | North Indian | Medium | — | |
| Aloo Gobi | North Indian | Easy | — | |
| **Paneer** | North Indian | Medium | 45 min | 7 variations (see below) |
| Kaju Masala | North Indian | Medium | 50 min | Cashew gravy |
| Rajma Masala | North Indian | Medium | — | Dhaba style |
| Pani Puri Pani | Indian Street Food | Easy | 25 min | Mint-tamarind water |
| Masala Puri | Indian Street Food | Medium | 40 min | Dry peas + tamarind masala |
| **Phuchka & Churmur** | Indian Street Food | Hard | 45 min | Multi-dish · Kolkata style |
| Thecha Paneer Rice | Maharashtrian | Easy | 35 min | Charred chilli-garlic paste |
| Paneer Hot Garlic Sauce & Fried Rice | Indo-Chinese | Medium | 40 min | Multi-dish · Wok hei |

**Paneer variations:** Lababdar (base) · Butter Masala · Chilli Paneer · Makhani Burger · Spicy Burger · Do Pyaaza · Palak Paneer · Kaju Masala

---

## ✅ Features Built

### Core
- [x] Recipe grid with search (by name and ingredient) and cuisine filter chips
- [x] Variation picker — horizontal chip row; swaps ingredients, steps, accent colour, and hero photo
- [x] Servings scaler — auto-scales all ingredient amounts with smart fraction display (½, ¾, etc.)
- [x] Ingredient check view — shows have vs. missing; adds missing items to grocery list in one tap
- [x] Cooking mode — dark full-screen step-by-step with per-step countdown timers
- [x] Timer warning when navigating away from a running step
- [x] Weekly meal planner — assign Breakfast / Lunch / Dinner per day; "Add day to grocery list"
- [x] Grocery list — categorised, tap to check/uncheck, swipe to delete, clear checked
- [x] Add / edit custom recipes — name, icon, cuisine, difficulty, time, servings, colour, ingredients, steps

### Photos
- [x] Real food photos on all seed recipe cards (Unsplash free licence)
- [x] Unique photo per Paneer variation (8 photos)
- [x] Unique photo per Chia Seed Pudding variation (7 photos)
- [x] Tapping a variation chip swaps the hero photo

### Login & Sync
- [x] Sign in with Apple gate (bypassed on simulator automatically)
- [x] Core Data persistence (replaces UserDefaults; one-time migration on first update)
- [x] NSPersistentCloudKitContainer — auto-syncs to iCloud when entitlement is set
- [x] Household sharing via CloudKit CKShare — invite link through `UICloudSharingController`
- [x] Settings tab — account info, share/manage household, sign out

### UX Polish
- [x] Variation accent colour flows through hero gradient, step numbers, timer text, Start Cooking button
- [x] Smart grocery category inference (70+ Indian pantry keywords)
- [x] Edit / delete only visible on user-added recipes
- [x] Toast banner in Meal Plan after adding day to grocery list
- [x] "You're all set!" success banner in Ingredient Check when everything is on the list
- [x] Keyboard Done button on decimal pad fields in AddRecipeView

---

## 🔲 What's Left

### Recipes
- [ ] More breakfast options (oats, parathas, idli/dosa, smoothies)
- [ ] Snacks / drinks category (no MealType for it yet)

### Features
- [ ] **Meal plan → variation picker** — no way to pick *which* Paneer or Chia variation you plan to cook
- [ ] **Grocery deduplication** — if two day's recipes share an ingredient, quantities are not summed
- [ ] **Recipe search across variations** — search only checks base recipe ingredients, not variations
- [ ] **User recipe photos** — AddRecipeView has no photo picker; user recipes show SF Symbol fallback
- [ ] **Reorder ingredients / steps** — swipe-to-delete exists but no drag reorder in AddRecipeView
- [ ] **Nutrition info** — no calorie or macro tracking
- [ ] **Share / export recipe** — no way to share a recipe card outside the app

### Technical
- [ ] **iCloud entitlements** — must be added manually in Xcode Signing & Capabilities (see setup note above)
- [ ] SourceKit shows false-positive errors throughout (SourceKit indexer lag — all `xcodebuild` builds succeed)

---

## 🗺️ File Map

```mermaid
graph LR
    subgraph Models
        RM[Recipe.swift\nRecipe · RecipeVariation\nIngredient · Step\nDifficulty · MealType]
        GM[GroceryItem.swift\nGroceryItem · GroceryCategory]
        MM[MealPlan.swift\nMealPlanEntry · MealSlotType]
    end

    subgraph Data
        RS[RecipeStore.swift]
        GS[GroceryStore.swift]
        MPS[MealPlanStore.swift]
        PC[PersistenceController.swift\nCore Data + CloudKit]
        AM[AuthManager.swift\nSign in with Apple]
        SM[SharingManager.swift\nCKShare household]
        SR[SeedRecipes.swift\n16 built-in recipes]
        CE[CoreDataEntities.swift\nNSManagedObject subclasses]
    end

    subgraph Views
        HV2[HomeView.swift]
        RDV2[RecipeDetailView.swift]
        ICV2[IngredientCheckView.swift]
        CMV2[CookingModeView.swift]
        GLV2[GroceryListView.swift]
        MPV2[MealPlanView.swift]
        ARV2[AddRecipeView.swift]
        AV2[AuthView.swift]
        SV2[SettingsView.swift]
        CO[Components.swift\nRecipeCard · Color hex]
    end

    subgraph Root
        APP[CookingAppApp.swift\nEntry point · TabView · Auth gate]
        CDM[CookingApp.xcdatamodeld\nCore Data schema]
        ASS[Assets.xcassets\n24 food photo imagesets]
    end
```

| File | Lines | Purpose |
|------|-------|---------|
| `Data/SeedRecipes.swift` | ~1280 | All 16 built-in recipes as static lets |
| `Models/Recipe.swift` | 161 | Core model structs |
| `Views/RecipeDetailView.swift` | 290 | Hero, variation picker, ingredients, steps |
| `Views/CookingModeView.swift` | — | Dark step-by-step with countdown timers |
| `Data/PersistenceController.swift` | ~100 | Core Data + CloudKit container |
| `CookingApp.xcdatamodeld` | — | 3 entities: RecipeEntity, GroceryItemEntity, MealPlanEntryEntity |

---

## 🔑 UserDefaults Keys (Auth only)

| Key | Used by | Purpose |
|-----|---------|---------|
| `siwa_userID` | AuthManager | Apple user ID for credential re-validation |
| `siwa_displayName` | AuthManager | Display name from first sign-in |

> [!note] Data migration
> On first launch after the Core Data update, `PersistenceController.migrateLegacyDataIfNeeded()` reads `"userRecipes"`, `"groceryItems"`, and `"mealPlanEntries"` from UserDefaults and imports them into Core Data, then clears those keys. No data is lost on update.

---

## 🧩 Key Patterns

### Variation swapping
```swift
// Recipe.applying(_:) returns a merged copy with variation's data
private var effectiveRecipe: Recipe {
    selectedVariation.map { recipe.applying($0) } ?? recipe
}
// heroImage, ingredients, steps, accent colour all read effectiveRecipe
```

### CloudKit guard (no entitlement = no crash)
```swift
static var cloudKitEnabled: Bool {
    let ids = Bundle.main.object(forInfoDictionaryKey:
        "com.apple.developer.icloud-container-identifiers") as? [String]
    return ids?.isEmpty == false
}
// All CKContainer calls are guarded: if PersistenceController.cloudKitEnabled { … }
```

### Smart grocery categories
```swift
GroceryCategory.infer(from: "toor dal")   // → .legumes
GroceryCategory.infer(from: "kasuri methi") // → .herbs
GroceryCategory.infer(from: "paneer")     // → .dairy
```
