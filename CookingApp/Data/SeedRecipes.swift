import Foundation

enum SeedRecipes {
    static let all: [Recipe] = [
        vegBiryani, masalaDosa, dalTadka,
        palakPaneer, chanaMasala, alooGobi,
        sambar, rajma
    ]

    static let vegBiryani = Recipe(
        name: "Vegetable Biryani",
        cuisine: "Hyderabadi",
        difficulty: .medium,
        totalMinutes: 50,
        defaultServings: 4,
        sfSymbol: "flame.fill",
        accentHex: "4CAF50",
        isMultiDish: true,
        ingredients: [
            Ingredient(name: "Basmati rice", amount: 2, unit: "cups"),
            Ingredient(name: "Mixed vegetables (carrot, beans, peas, potato)", amount: 2, unit: "cups"),
            Ingredient(name: "Yogurt", amount: 1, unit: "cup"),
            Ingredient(name: "Biryani masala", amount: 2, unit: "tbsp"),
            Ingredient(name: "Fried onions", amount: 1, unit: "cup"),
            Ingredient(name: "Mint leaves", amount: 0.5, unit: "cup"),
            Ingredient(name: "Ghee", amount: 3, unit: "tbsp"),
            Ingredient(name: "Saffron strands", amount: 1, unit: "pinch")
        ],
        steps: [
            Step(order: 1, instruction: "Marinate vegetables with yogurt, biryani masala, and salt. Rest 20 minutes.", tip: "Use carrots, beans, peas, and potatoes for best results.", timerSeconds: 1200),
            Step(order: 2, instruction: "Soak basmati rice in water for 20 minutes, then drain.", timerSeconds: 1200),
            Step(order: 3, instruction: "Boil water with whole spices (bay leaf, cloves, cardamom). Add rice and cook until 70% done.", timerSeconds: 420),
            Step(order: 4, instruction: "In a heavy pot, layer marinated vegetables at the bottom, then rice on top.", tip: "Heavy-bottomed pot prevents burning."),
            Step(order: 5, instruction: "Add fried onions, mint, saffron milk, and ghee. Seal the lid.", tip: "Use dough to seal the lid for authentic dum."),
            Step(order: 6, instruction: "Cook on high for 5 min, then low for 25 min. Don't open the lid.", timerSeconds: 1800),
            Step(order: 7, instruction: "Rest 10 minutes before opening. Fluff gently and serve.", timerSeconds: 600)
        ]
    )

    static let masalaDosa = Recipe(
        name: "Masala Dosa",
        cuisine: "South Indian",
        difficulty: .medium,
        totalMinutes: 40,
        defaultServings: 2,
        sfSymbol: "fork.knife",
        accentHex: "FFA62B",
        isMultiDish: true,
        ingredients: [
            Ingredient(name: "Dosa batter", amount: 2, unit: "cups"),
            Ingredient(name: "Potatoes", amount: 3, unit: "medium"),
            Ingredient(name: "Onion", amount: 1, unit: "large"),
            Ingredient(name: "Mustard seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Curry leaves", amount: 10, unit: "leaves"),
            Ingredient(name: "Turmeric", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Green chilies", amount: 2, unit: "nos"),
            Ingredient(name: "Oil", amount: 2, unit: "tbsp")
        ],
        steps: [
            Step(order: 1, instruction: "Boil potatoes until fork-tender, then peel and mash coarsely.", timerSeconds: 900),
            Step(order: 2, instruction: "Heat oil. Splutter mustard seeds, add curry leaves and green chilies."),
            Step(order: 3, instruction: "Add chopped onions. Sauté until translucent.", timerSeconds: 240),
            Step(order: 4, instruction: "Add turmeric and mashed potatoes. Mix well and cook 3 minutes.", timerSeconds: 180),
            Step(order: 5, instruction: "Heat a flat pan. Pour a ladle of batter and spread thin in circles.", tip: "Pan should be medium-hot — water droplets should sizzle."),
            Step(order: 6, instruction: "Drizzle oil around edges. Cook until golden and crisp.", timerSeconds: 120),
            Step(order: 7, instruction: "Place potato filling in center, fold, and serve with chutney.")
        ]
    )

    static let dalTadka = Recipe(
        name: "Dal Tadka",
        cuisine: "North Indian",
        difficulty: .easy,
        totalMinutes: 25,
        defaultServings: 3,
        sfSymbol: "drop.fill",
        accentHex: "FFD60A",
        isMultiDish: false,
        ingredients: [
            Ingredient(name: "Toor dal", amount: 1, unit: "cup"),
            Ingredient(name: "Tomato", amount: 1, unit: "large"),
            Ingredient(name: "Onion", amount: 1, unit: "medium"),
            Ingredient(name: "Ginger-garlic paste", amount: 1, unit: "tbsp"),
            Ingredient(name: "Turmeric", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Ghee", amount: 2, unit: "tbsp"),
            Ingredient(name: "Red chili powder", amount: 1, unit: "tsp")
        ],
        steps: [
            Step(order: 1, instruction: "Rinse dal and pressure cook with turmeric and salt until soft.", timerSeconds: 900),
            Step(order: 2, instruction: "Heat ghee in a pan. Add cumin seeds until they splutter."),
            Step(order: 3, instruction: "Add chopped onions and sauté until golden.", timerSeconds: 300),
            Step(order: 4, instruction: "Add ginger-garlic paste and chopped tomato. Cook until soft.", timerSeconds: 240),
            Step(order: 5, instruction: "Add red chili powder. Pour in cooked dal. Simmer 5 minutes.", timerSeconds: 300),
            Step(order: 6, instruction: "Garnish with fresh coriander. Serve hot with rice or roti.")
        ]
    )

    static let chanaMasala = Recipe(
        name: "Dhaba Style Chana Masala",
        cuisine: "North Indian",
        difficulty: .medium,
        totalMinutes: 60,
        defaultServings: 4,
        sfSymbol: "sparkles",
        accentHex: "8D6E63",
        isMultiDish: false,
        ingredients: [
            Ingredient(name: "Dried chickpeas (soaked overnight)", amount: 250, unit: "g"),
            Ingredient(name: "Bay leaf", amount: 1, unit: "no."),
            Ingredient(name: "Cinnamon stick (2-3 inch)", amount: 1, unit: "piece"),
            Ingredient(name: "Black cardamom", amount: 1, unit: "no."),
            Ingredient(name: "Cloves", amount: 4, unit: "nos."),
            Ingredient(name: "Baking soda", amount: 1, unit: "pinch"),
            Ingredient(name: "Onion", amount: 3, unit: "medium"),
            Ingredient(name: "Tomato", amount: 3, unit: "nos."),
            Ingredient(name: "Ginger (2-inch piece)", amount: 1, unit: "piece"),
            Ingredient(name: "Green chili", amount: 2, unit: "nos."),
            Ingredient(name: "Garlic cloves", amount: 12, unit: "nos."),
            Ingredient(name: "Ghee", amount: 2, unit: "tbsp"),
            Ingredient(name: "Oil", amount: 1, unit: "tbsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Carom seeds (ajwain)", amount: 1, unit: "pinch"),
            Ingredient(name: "Asafoetida (hing)", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Turmeric powder", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Kashmiri red chili powder", amount: 1, unit: "tbsp"),
            Ingredient(name: "Coriander powder", amount: 2, unit: "tbsp"),
            Ingredient(name: "Cumin powder", amount: 1, unit: "tsp"),
            Ingredient(name: "Yellow chili powder", amount: 1, unit: "tsp"),
            Ingredient(name: "Dry mango powder (amchur)", amount: 1, unit: "tsp"),
            Ingredient(name: "Black salt", amount: 1, unit: "large pinch"),
            Ingredient(name: "Kasuri methi", amount: 1, unit: "tbsp"),
            Ingredient(name: "Garam masala", amount: 1, unit: "pinch"),
            Ingredient(name: "Fresh coriander (chopped)", amount: 1, unit: "handful"),
            Ingredient(name: "Ginger julienne", amount: 1, unit: "handful"),
            Ingredient(name: "Green chili (sliced, for garnish)", amount: 2, unit: "nos.")
        ],
        steps: [
            Step(order: 1, instruction: "Soak chickpeas in water for 6–8 hours or overnight. Discard soaking water and wash thoroughly to remove any smell.", tip: "Soaking overnight gives softer, evenly cooked chickpeas."),
            Step(order: 2, instruction: "Pressure cook chickpeas with bay leaf, cinnamon, black cardamom, cloves, salt, baking soda, and enough water (1 inch above chickpeas). Cook on high for 1 whistle, then medium for 4–5 more whistles.", timerSeconds: 1500),
            Step(order: 3, instruction: "Let pressure release naturally. Open and check — chickpeas should be completely soft. If not, cook 1–2 more whistles. Discard whole spices and set chickpeas aside."),
            Step(order: 4, instruction: "Blend onions into a smooth paste. In a separate jar, blend tomatoes, ginger, green chilies, and garlic into a fine purée."),
            Step(order: 5, instruction: "Heat ghee and oil together in a kadhai on high flame. Add cumin seeds, carom seeds, and asafoetida. Let them splutter, then add onion paste. Stir well.", tip: "Add splashes of hot water if the onion paste sticks to the pan."),
            Step(order: 6, instruction: "Cook onion paste on high, stirring continuously, until it turns deep golden brown. This is the base of the dish.", timerSeconds: 600),
            Step(order: 7, instruction: "Lower the flame, add all the powdered spices (turmeric, Kashmiri chili, coriander, cumin, yellow chili, amchur, black salt) with a splash of water. Stir and cook on high for 1–2 minutes.", timerSeconds: 90),
            Step(order: 8, instruction: "Add tomato purée with salt. Cook on high, stirring often, until ghee separates and masala turns crumbly — about 10–12 minutes. Add hot water if it dries out.", tip: "Don't rush this step — fully cooked masala removes rawness.", timerSeconds: 720),
            Step(order: 9, instruction: "Add cooked chickpeas. Stir well and simmer for 6–8 minutes until gravy is semi-thick.", timerSeconds: 480),
            Step(order: 10, instruction: "Mash a few chickpeas against the pot with the back of a spoon to naturally thicken the gravy.", tip: "This is faster than simmering longer."),
            Step(order: 11, instruction: "Dry roast kasuri methi in a separate pan on medium, then crush between your palms. Add to the gravy along with ginger julienne, sliced green chili, garam masala, and fresh coriander. Stir well.", tip: "Crushing kasuri methi between warm palms releases its full aroma."),
            Step(order: 12, instruction: "Serve hot with tandoori roti, bread kulcha, or jeera rice.")
        ]
    )

    static let palakPaneer = Recipe(
        name: "Palak Paneer",
        cuisine: "North Indian",
        difficulty: .medium,
        totalMinutes: 35,
        defaultServings: 3,
        sfSymbol: "leaf.fill",
        accentHex: "2E7D32",
        isMultiDish: false,
        ingredients: [
            Ingredient(name: "Spinach", amount: 300, unit: "g"),
            Ingredient(name: "Paneer", amount: 200, unit: "g"),
            Ingredient(name: "Onion", amount: 1, unit: "large"),
            Ingredient(name: "Tomato", amount: 2, unit: "medium"),
            Ingredient(name: "Ginger-garlic paste", amount: 1, unit: "tbsp"),
            Ingredient(name: "Heavy cream", amount: 3, unit: "tbsp"),
            Ingredient(name: "Garam masala", amount: 1, unit: "tsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Oil", amount: 2, unit: "tbsp")
        ],
        steps: [
            Step(order: 1, instruction: "Blanch spinach in boiling salted water for 2 minutes, then transfer immediately to ice water.", tip: "Ice bath keeps the spinach vibrant green.", timerSeconds: 120),
            Step(order: 2, instruction: "Drain spinach and blend into a smooth purée. Set aside."),
            Step(order: 3, instruction: "Heat oil, add cumin seeds. Add chopped onions and sauté until golden.", timerSeconds: 360),
            Step(order: 4, instruction: "Add ginger-garlic paste and chopped tomatoes. Cook until oil separates.", timerSeconds: 300),
            Step(order: 5, instruction: "Add garam masala and spinach purée. Simmer 5 minutes.", timerSeconds: 300),
            Step(order: 6, instruction: "Add paneer cubes and cream. Stir gently and cook 3 more minutes.", tip: "Pan-fry paneer first for a firmer, golden texture.", timerSeconds: 180),
            Step(order: 7, instruction: "Season with salt. Serve hot with naan or jeera rice.")
        ]
    )

    static let alooGobi = Recipe(
        name: "Aloo Gobi",
        cuisine: "North Indian",
        difficulty: .easy,
        totalMinutes: 25,
        defaultServings: 3,
        sfSymbol: "sun.max.fill",
        accentHex: "F9A825",
        isMultiDish: false,
        ingredients: [
            Ingredient(name: "Cauliflower", amount: 1, unit: "medium head"),
            Ingredient(name: "Potatoes", amount: 2, unit: "medium"),
            Ingredient(name: "Onion", amount: 1, unit: "medium"),
            Ingredient(name: "Tomato", amount: 1, unit: "large"),
            Ingredient(name: "Ginger-garlic paste", amount: 1, unit: "tbsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Turmeric", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Coriander powder", amount: 1, unit: "tsp"),
            Ingredient(name: "Oil", amount: 3, unit: "tbsp")
        ],
        steps: [
            Step(order: 1, instruction: "Cut cauliflower into florets and dice potatoes into 1-inch cubes."),
            Step(order: 2, instruction: "Heat oil. Add cumin seeds and let them splutter."),
            Step(order: 3, instruction: "Add onions and sauté until translucent. Add ginger-garlic paste.", timerSeconds: 240),
            Step(order: 4, instruction: "Add chopped tomato, turmeric, and coriander powder. Cook until soft.", timerSeconds: 180),
            Step(order: 5, instruction: "Add potatoes and stir to coat with masala. Cover and cook 5 minutes.", timerSeconds: 300),
            Step(order: 6, instruction: "Add cauliflower. Stir, cover and cook until both are tender.", tip: "Sprinkle a little water if sticking.", timerSeconds: 480),
            Step(order: 7, instruction: "Season with salt and garam masala. Garnish with coriander. Serve with roti.")
        ]
    )

    static let sambar = Recipe(
        name: "Sambar",
        cuisine: "South Indian",
        difficulty: .easy,
        totalMinutes: 40,
        defaultServings: 4,
        sfSymbol: "waveform",
        accentHex: "FF7043",
        isMultiDish: false,
        ingredients: [
            Ingredient(name: "Toor dal", amount: 1, unit: "cup"),
            Ingredient(name: "Tamarind", amount: 2, unit: "tbsp"),
            Ingredient(name: "Sambar powder", amount: 2, unit: "tbsp"),
            Ingredient(name: "Drumstick (moringa)", amount: 2, unit: "pieces"),
            Ingredient(name: "Pearl onions", amount: 10, unit: "nos"),
            Ingredient(name: "Tomato", amount: 2, unit: "medium"),
            Ingredient(name: "Mustard seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Curry leaves", amount: 10, unit: "leaves"),
            Ingredient(name: "Oil", amount: 2, unit: "tbsp")
        ],
        steps: [
            Step(order: 1, instruction: "Pressure cook toor dal with turmeric until soft. Mash and set aside.", timerSeconds: 900),
            Step(order: 2, instruction: "Soak tamarind in 1 cup warm water for 10 minutes. Squeeze out pulp.", timerSeconds: 600),
            Step(order: 3, instruction: "Heat oil. Add mustard seeds, curry leaves, and pearl onions.", timerSeconds: 120),
            Step(order: 4, instruction: "Add tomatoes and cook until soft. Add drumstick pieces.", timerSeconds: 180),
            Step(order: 5, instruction: "Pour in tamarind water and sambar powder. Boil 10 minutes.", timerSeconds: 600),
            Step(order: 6, instruction: "Add mashed dal and simmer 5 minutes. Adjust consistency with water.", tip: "Sambar thickens as it cools — keep it slightly thin.", timerSeconds: 300),
            Step(order: 7, instruction: "Finish with a tempering of mustard seeds and dry red chilies in ghee. Serve with idli or rice.")
        ]
    )

    static let rajma = Recipe(
        name: "Rajma",
        cuisine: "North Indian",
        difficulty: .medium,
        totalMinutes: 45,
        defaultServings: 4,
        sfSymbol: "heart.fill",
        accentHex: "C62828",
        isMultiDish: false,
        ingredients: [
            Ingredient(name: "Red kidney beans (cooked)", amount: 2, unit: "cups"),
            Ingredient(name: "Onion", amount: 2, unit: "large"),
            Ingredient(name: "Tomatoes", amount: 3, unit: "large"),
            Ingredient(name: "Ginger-garlic paste", amount: 1.5, unit: "tbsp"),
            Ingredient(name: "Rajma masala", amount: 2, unit: "tbsp"),
            Ingredient(name: "Turmeric", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Butter", amount: 2, unit: "tbsp")
        ],
        steps: [
            Step(order: 1, instruction: "Heat butter in a heavy pot. Add cumin seeds until they splutter."),
            Step(order: 2, instruction: "Add finely chopped onions. Cook on medium until deep golden brown.", tip: "Don't rush this step — it builds the base flavor.", timerSeconds: 600),
            Step(order: 3, instruction: "Add ginger-garlic paste. Sauté 2 minutes.", timerSeconds: 120),
            Step(order: 4, instruction: "Add blended tomatoes and cook until oil separates, about 8 minutes.", timerSeconds: 480),
            Step(order: 5, instruction: "Add rajma masala, turmeric, and salt. Stir well."),
            Step(order: 6, instruction: "Add kidney beans with 1.5 cups water. Bring to boil, then simmer 20 minutes.", timerSeconds: 1200),
            Step(order: 7, instruction: "Mash a few beans against the pot to thicken the gravy. Serve over steamed rice.")
        ]
    )
}
