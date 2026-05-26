# CookingApp

An iOS app for browsing recipes, following cooking mode step-by-step, and managing a grocery list. Built with SwiftUI.

## Features

- Browse and add recipes with ingredients and steps
- Guided cooking mode with ingredient check-off
- Grocery list that auto-populates from recipe ingredients
- Seeded with sample recipes on first launch

## Structure

```
CookingApp/
├── CookingApp/
│   ├── CookingAppApp.swift    # App entry point
│   ├── ContentView.swift      # Root navigation
│   ├── Models/
│   │   ├── Recipe.swift       # Recipe + Step data models
│   │   └── GroceryItem.swift  # Grocery item model
│   ├── Views/
│   │   ├── HomeView.swift
│   │   ├── RecipeDetailView.swift
│   │   ├── AddRecipeView.swift
│   │   ├── CookingModeView.swift
│   │   ├── IngredientCheckView.swift
│   │   └── GroceryListView.swift
│   └── Data/
│       ├── RecipeStore.swift  # Recipe persistence
│       ├── GroceryStore.swift # Grocery list persistence
│       └── SeedRecipes.swift  # Default recipe data
├── CookingAppTests/
└── CookingAppUITests/
```

## Requirements

- Xcode 16+
- iOS 17+
- Swift 5.9+

## Getting Started

1. Clone the repo
2. Open `CookingApp.xcodeproj` in Xcode
3. Run on a simulator (`Cmd+R`)
