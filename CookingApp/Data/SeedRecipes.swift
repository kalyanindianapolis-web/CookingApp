import Foundation

enum SeedRecipes {
    static let all: [Recipe] = [
        dalTadka, jeeraRice, bagaraRice, chanaMasala, alooGobi,
        paneerDahiSandwich, paneerLababdar,
        baseChiaPudding, mangoCoconutChia, orangeCreamsicleChia,
        veryBerryChia, applePieChia, pumpkinSpiceChia, chocolateBananaChia
    ]

    static let dalTadka = Recipe(
        name: "Dal Tadka",
        cuisine: "North Indian",
        difficulty: .medium,
        totalMinutes: 45,
        defaultServings: 4,
        sfSymbol: "drop.fill",
        accentHex: "FFD60A",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            Ingredient(name: "Toor dal", amount: 0.5, unit: "cup"),
            Ingredient(name: "Chana dal", amount: 2, unit: "tbsp"),
            Ingredient(name: "Masoor dal", amount: 2, unit: "tbsp"),
            Ingredient(name: "Green chilli (slit)", amount: 1, unit: "no."),
            Ingredient(name: "Turmeric powder", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Ginger julienne", amount: 1, unit: "inch piece"),
            Ingredient(name: "Ghee", amount: 2, unit: "tbsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Red chilli", amount: 1, unit: "no."),
            Ingredient(name: "Ginger (chopped)", amount: 1, unit: "tbsp"),
            Ingredient(name: "Garlic (chopped)", amount: 1, unit: "tbsp"),
            Ingredient(name: "Green chilli (chopped)", amount: 3, unit: "nos."),
            Ingredient(name: "Onion (chopped)", amount: 1, unit: "no."),
            Ingredient(name: "Tomato (chopped)", amount: 1, unit: "no."),
            Ingredient(name: "Kashmiri red chilli powder", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Coriander powder", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Garam masala", amount: 1, unit: "pinch"),
            Ingredient(name: "Roasted kasuri methi powder", amount: 1, unit: "pinch"),
            Ingredient(name: "Dry mango powder (amchur)", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Butter", amount: 1, unit: "tbsp"),
            Ingredient(name: "Fresh coriander", amount: 1, unit: "small handful"),
            Ingredient(name: "Ghee (2nd tadka)", amount: 1, unit: "tbsp"),
            Ingredient(name: "Onion (sliced)", amount: 0.5, unit: "no."),
            Ingredient(name: "Asafoetida (hing)", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Salt", amount: 1, unit: "to taste")
        ],
        steps: [
            Step(order: 1, instruction: "Wash all three dals together until the water runs clear. Soak in fresh water for 30–60 minutes, then discard the soaking water.", timerSeconds: 1800),
            Step(order: 2, instruction: "Transfer drained dals to a pressure cooker. Add slit green chilli, salt, turmeric, ginger julienne, and 2.5 cups water. Pressure cook for 3–4 whistles on medium-high flame.", timerSeconds: 900),
            Step(order: 3, instruction: "Switch off and let pressure release naturally. Open, discard the green chilli, and stir the dal well. Set aside."),
            Step(order: 4, instruction: "For the 1st tadka: heat a large pan on high and add 2 tbsp ghee. Add cumin seeds, red chilli, chopped ginger, garlic, and green chilli. Cook on medium for 1 minute.", timerSeconds: 60),
            Step(order: 5, instruction: "Add chopped onion and cook until light golden brown.", timerSeconds: 300),
            Step(order: 6, instruction: "Add chopped tomato and salt. Cook until mushy. Add all powdered spices (turmeric, Kashmiri chilli, coriander, garam masala) and a splash of water. Carefully tilt the pan toward the flame for a few seconds.", tip: "Tilting the pan so the flame enters creates a smoky dhaba flavour — do this carefully and only briefly."),
            Step(order: 7, instruction: "Add the boiled dal and stir well. Bring to a boil. Add kasuri methi powder, dry mango powder, butter, and fresh coriander. Mix well."),
            Step(order: 8, instruction: "For the 2nd tadka: heat a small pan, add 1 tbsp ghee. Fry sliced onion until light golden. Add red chilli, asafoetida, and Kashmiri chilli powder. Immediately pour over the dal and serve hot.", timerSeconds: 180)
        ]
    )

    static let jeeraRice = Recipe(
        name: "Jeera Rice",
        cuisine: "North Indian",
        difficulty: .easy,
        totalMinutes: 20,
        defaultServings: 4,
        sfSymbol: "fork.knife",
        accentHex: "A5D6A7",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            Ingredient(name: "Basmati rice", amount: 1, unit: "cup"),
            Ingredient(name: "Lemon juice", amount: 1, unit: "tsp"),
            Ingredient(name: "Ghee", amount: 2, unit: "tbsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Fresh coriander", amount: 1, unit: "small handful"),
            Ingredient(name: "Salt", amount: 1, unit: "to taste")
        ],
        steps: [
            Step(order: 1, instruction: "Wash rice until water runs clear. Soak in fresh water for 30–45 minutes, then drain.", tip: "Soaking rice ensures it cooks evenly and stays fluffy.", timerSeconds: 1800),
            Step(order: 2, instruction: "Bring a large pot of water to a rolling boil. Add salt and lemon juice with the slice. Add soaked, drained rice. Cook until 90% done — about 4–5 minutes.", timerSeconds: 300),
            Step(order: 3, instruction: "Drain through a sieve and fluff gently with forks to release steam. Spread out and cool completely.", tip: "Cooling the rice prevents it from going mushy when tossed in the wok."),
            Step(order: 4, instruction: "Heat a wok on high and add ghee. Once hot, add cumin seeds and let them crackle. Add cooled rice, salt, and fresh coriander. Toss on high flame for a few seconds and serve.", timerSeconds: 60)
        ]
    )

    static let bagaraRice = Recipe(
        name: "Bagara Rice",
        cuisine: "Hyderabadi",
        difficulty: .easy,
        totalMinutes: 65,
        defaultServings: 6,
        sfSymbol: "leaf.fill",
        accentHex: "FF8F00",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            Ingredient(name: "Basmati rice", amount: 2, unit: "cups"),
            Ingredient(name: "Ghee", amount: 4, unit: "tbsp"),
            Ingredient(name: "Cinnamon stick", amount: 1, unit: "inch piece"),
            Ingredient(name: "Cloves", amount: 6, unit: "nos."),
            Ingredient(name: "Shah zeera (caraway seeds)", amount: 1, unit: "tbsp"),
            Ingredient(name: "Star anise", amount: 2, unit: "nos."),
            Ingredient(name: "Bay leaf", amount: 2, unit: "nos."),
            Ingredient(name: "Onion (sliced)", amount: 1, unit: "cup"),
            Ingredient(name: "Green chilli", amount: 2, unit: "nos."),
            Ingredient(name: "Mint (pudina)", amount: 1, unit: "small bunch"),
            Ingredient(name: "Fresh coriander (kothimir)", amount: 1, unit: "small bunch"),
            Ingredient(name: "Ginger garlic paste", amount: 1, unit: "tbsp"),
            Ingredient(name: "Salt", amount: 1, unit: "to taste"),
            Ingredient(name: "Hot water", amount: 3.5, unit: "cups")
        ],
        steps: [
            Step(order: 1, instruction: "Wash basmati rice well and soak in fresh water for 1 hour. Drain before using.", timerSeconds: 3600),
            Step(order: 2, instruction: "Melt ghee in a pressure cooker over medium heat. Add cinnamon, cloves, shah zeera, star anise, and bay leaves. Fry until aromatic.", tip: "Don't rush this step — frying the whole spices in ghee builds the fragrant base of the rice."),
            Step(order: 3, instruction: "Add sliced onions and fry until golden brown.", timerSeconds: 360),
            Step(order: 4, instruction: "Add green chillies, mint, coriander, and ginger garlic paste. Fry well with the onions for 1–2 minutes.", timerSeconds: 120),
            Step(order: 5, instruction: "Add the soaked, drained rice and salt. Fry together for 2 minutes so the rice is well coated.", timerSeconds: 120),
            Step(order: 6, instruction: "Add hot water. Top with extra chopped coriander and mint. Stir gently to mix.", tip: "Use hot water — adding cold water can make the rice gummy."),
            Step(order: 7, instruction: "Close the pressure cooker lid. Cook on high flame until 2 whistles, then take off the flame. Let the steam release naturally before opening.", timerSeconds: 600)
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
        mealType: .lunchDinner,
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

    static let alooGobi = Recipe(
        name: "Aloo Gobi",
        cuisine: "North Indian",
        difficulty: .easy,
        totalMinutes: 35,
        defaultServings: 3,
        sfSymbol: "sun.max.fill",
        accentHex: "F9A825",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            Ingredient(name: "Cauliflower", amount: 500, unit: "g"),
            Ingredient(name: "Potatoes", amount: 3, unit: "medium"),
            Ingredient(name: "Ginger", amount: 3, unit: "inch piece"),
            Ingredient(name: "Green chilli", amount: 3, unit: "nos."),
            Ingredient(name: "Mustard oil", amount: 3, unit: "tbsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Ajwain (carom seeds)", amount: 1, unit: "pinch"),
            Ingredient(name: "Hing (asafoetida)", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Turmeric powder", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Coriander powder", amount: 2, unit: "tsp"),
            Ingredient(name: "Garam masala", amount: 1, unit: "pinch"),
            Ingredient(name: "Cumin powder", amount: 1, unit: "pinch"),
            Ingredient(name: "Dry mango powder (amchur)", amount: 1, unit: "pinch"),
            Ingredient(name: "Fresh coriander", amount: 1, unit: "handful"),
            Ingredient(name: "Salt", amount: 1, unit: "to taste")
        ],
        steps: [
            Step(order: 1, instruction: "Remove the cauliflower core and cut into medium bite-sized florets. Peel the stem, cut the tender inner part into pieces. Wash thoroughly in salted water and keep submerged.", tip: "The cauliflower stem is often discarded but cooks like potato — don't waste it."),
            Step(order: 2, instruction: "Peel the potatoes and cut into similar-sized pieces. Keep submerged in water to prevent oxidation."),
            Step(order: 3, instruction: "Using a mortar and pestle, pound ginger and green chillies into a coarse paste. Set aside."),
            Step(order: 4, instruction: "Heat mustard oil in a kadhai on high until it lightly smokes. Lower the flame. Add cumin seeds, ajwain, and hing — let them crackle.", tip: "Smoking mustard oil removes its pungency and creates the distinct authentic flavour."),
            Step(order: 5, instruction: "Add drained potato pieces. Stir and cook on medium-high for 1 minute. Cover and cook on the lowest flame for 3–4 minutes until potatoes begin to soften.", timerSeconds: 300),
            Step(order: 6, instruction: "Uncover, stir, then add the ginger–chilli paste and drained cauliflower. Mix well. Cover and cook for 2–3 minutes to let the vegetables steam and release moisture.", timerSeconds: 180),
            Step(order: 7, instruction: "Remove lid. Add salt, turmeric, coriander powder, garam masala, and cumin powder. Stir gently to coat. Cover and cook on low for 10–15 minutes, stirring occasionally, until potatoes and cauliflower are fully tender.", tip: "Low and slow is key — don't rush with high heat or the vegetables will brown unevenly.", timerSeconds: 720),
            Step(order: 8, instruction: "Taste and adjust salt. Finish with dry mango powder and fresh coriander. Mix gently and serve hot with chapati, laccha paratha, or puris.")
        ]
    )

    static let paneerDahiSandwich = Recipe(
        name: "Paneer Dahi Sandwich",
        cuisine: "North Indian",
        difficulty: .easy,
        totalMinutes: 35,
        defaultServings: 2,
        sfSymbol: "square.stack.fill",
        accentHex: "F5A623",
        isMultiDish: false,
        mealType: .breakfast,
        ingredients: [
            Ingredient(name: "Full fat milk", amount: 1, unit: "litre"),
            Ingredient(name: "Vinegar", amount: 2, unit: "tbsp"),
            Ingredient(name: "Water", amount: 2, unit: "tbsp"),
            Ingredient(name: "Bell pepper", amount: 1, unit: "medium"),
            Ingredient(name: "Green chilli", amount: 2, unit: "nos"),
            Ingredient(name: "Fresh coriander", amount: 1, unit: "handful"),
            Ingredient(name: "Curd", amount: 2, unit: "tbsp"),
            Ingredient(name: "Salt", amount: 1, unit: "to taste"),
            Ingredient(name: "Black pepper", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Oregano", amount: 1, unit: "large pinch"),
            Ingredient(name: "Red chilli flakes", amount: 1, unit: "large pinch"),
            Ingredient(name: "Sandwich bread", amount: 6, unit: "slices"),
            Ingredient(name: "Soft butter", amount: 2, unit: "tbsp")
        ],
        steps: [
            Step(order: 1, instruction: "Add full fat milk to a pan and bring to a gentle boil, stirring as it heats. Switch off the flame and let it rest for 1–2 minutes.", timerSeconds: 120),
            Step(order: 2, instruction: "Mix vinegar and water in a bowl. Slowly add to the warm milk and stir lightly — the paneer will begin separating from the whey almost immediately."),
            Step(order: 3, instruction: "Strain through a fine strainer. Gently press out excess moisture and transfer paneer to a large bowl.", tip: "Do not squeeze too hard — keep the paneer soft and slightly moist, not dry and crumbly."),
            Step(order: 4, instruction: "Let the paneer cool completely before mixing the filling.", tip: "The leftover whey can be saved for kadhi, dough, dal, or any sabzi.", timerSeconds: 600),
            Step(order: 5, instruction: "While paneer cools, cut the bell pepper into planks. Roughly chop along with green chillies and fresh coriander. Add to a chopper and chop finely."),
            Step(order: 6, instruction: "Add the chopped vegetables to the cooled paneer along with curd, salt, black pepper, oregano, and red chilli flakes. Mix well and taste — adjust salt.", tip: "Get the seasoning right before assembling — you can't fix it after."),
            Step(order: 7, instruction: "Apply butter evenly on the bread slices. Spread the filling generously on one slice and place another slice on top."),
            Step(order: 8, instruction: "Heat a pan and apply butter on the surface. Place the sandwich and press firmly with a flat plate. Toast until the bottom is golden and crisp.", tip: "Pressing with a plate ensures even contact and a perfectly golden crust.", timerSeconds: 180),
            Step(order: 9, instruction: "Apply butter on the top side, flip the sandwich, press again with the plate, and toast until this side is also golden and crisp.", timerSeconds: 180),
            Step(order: 10, instruction: "Transfer to a chopping board, cut, and serve hot. Crispy on the outside, creamy and fresh on the inside.")
        ]
    )

    static let paneerLababdar = Recipe(
        name: "Paneer Lababdar",
        cuisine: "North Indian",
        difficulty: .medium,
        totalMinutes: 45,
        defaultServings: 5,
        sfSymbol: "crown.fill",
        accentHex: "E53935",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            // Base Gravy
            Ingredient(name: "Oil (base gravy)", amount: 3, unit: "tbsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Garlic", amount: 10, unit: "cloves"),
            Ingredient(name: "Ginger", amount: 2, unit: "inch piece"),
            Ingredient(name: "Green chilli (base)", amount: 3, unit: "nos."),
            Ingredient(name: "Onion (sliced)", amount: 2, unit: "medium"),
            Ingredient(name: "Bay leaf", amount: 2, unit: "nos."),
            Ingredient(name: "Cinnamon", amount: 1, unit: "inch piece"),
            Ingredient(name: "Green cardamom", amount: 4, unit: "nos."),
            Ingredient(name: "Tomato (base)", amount: 3, unit: "nos."),
            Ingredient(name: "Coriander stems", amount: 3, unit: "tbsp"),
            Ingredient(name: "Kashmiri red chilli powder (base)", amount: 1, unit: "tsp"),
            Ingredient(name: "Turmeric powder", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Kashmiri red chilli (whole)", amount: 5, unit: "nos."),
            Ingredient(name: "Cashews", amount: 15, unit: "nos."),
            Ingredient(name: "Melon seeds", amount: 3, unit: "tbsp"),
            // Sautéed Paneer
            Ingredient(name: "Paneer (cubed)", amount: 500, unit: "g"),
            Ingredient(name: "Oil (paneer)", amount: 2, unit: "tbsp"),
            Ingredient(name: "Kashmiri red chilli powder (paneer)", amount: 0.5, unit: "tsp"),
            // Final Cooking
            Ingredient(name: "Oil (final)", amount: 3, unit: "tbsp"),
            Ingredient(name: "Green chilli (chopped)", amount: 2, unit: "nos."),
            Ingredient(name: "Onion (chopped)", amount: 2, unit: "medium"),
            Ingredient(name: "Ginger garlic paste", amount: 1, unit: "tbsp"),
            Ingredient(name: "Coriander powder", amount: 1, unit: "tsp"),
            Ingredient(name: "Tomato (chopped)", amount: 2, unit: "nos."),
            Ingredient(name: "Capsicum", amount: 1, unit: "no."),
            Ingredient(name: "Fresh cream", amount: 4, unit: "tbsp"),
            Ingredient(name: "Butter", amount: 2, unit: "tbsp"),
            Ingredient(name: "Roasted kasuri methi powder", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Garam masala", amount: 1, unit: "pinch"),
            Ingredient(name: "Paneer (grated, for finishing)", amount: 30, unit: "g"),
            Ingredient(name: "Fresh coriander", amount: 1, unit: "small handful"),
            Ingredient(name: "Salt", amount: 1, unit: "to taste"),
            Ingredient(name: "Sugar", amount: 1, unit: "pinch")
        ],
        steps: [
            Step(order: 1, instruction: "Heat oil in a deep pan on high. Add cumin seeds, garlic, ginger, green chilli, and sliced onion. Add all whole spices (bay leaf, cinnamon, cardamom). Cook on high until onions turn translucent."),
            Step(order: 2, instruction: "Add tomatoes, coriander stems, salt, Kashmiri chilli powder, turmeric, whole Kashmiri red chillies, cashews, and melon seeds. Stir and cook briefly on high until tomatoes begin to soften."),
            Step(order: 3, instruction: "Add hot water as needed. Cover and cook on medium-high until tomatoes are completely mushy.", timerSeconds: 600),
            Step(order: 4, instruction: "Switch off flame. Discard whole spices. Cool the gravy completely, then blend into a smooth fine paste. Set aside as the base gravy.", tip: "Cool completely before blending — hot gravy in a blender can build pressure and splash."),
            Step(order: 5, instruction: "Heat 2 tbsp oil in a wok on high. Add paneer cubes, turmeric, Kashmiri chilli powder, and a pinch of salt. Toss on high flame until paneer gets a light golden coating. Transfer to a bowl.", tip: "Work fast on high heat — you want a light crust, not deep-fried paneer."),
            Step(order: 6, instruction: "In the same wok, heat 3 tbsp oil. Add cumin seeds, chopped green chilli, and chopped onions. Cook until onions turn golden brown.", timerSeconds: 300),
            Step(order: 7, instruction: "Add ginger garlic paste and cook briefly until the raw smell disappears.", timerSeconds: 60),
            Step(order: 8, instruction: "Lower the flame. Add turmeric, Kashmiri chilli powder, and coriander powder with a splash of hot water. Stir and cook the spices for 2 minutes.", timerSeconds: 120),
            Step(order: 9, instruction: "Add chopped tomatoes and salt. Cook on high until completely mushy.", timerSeconds: 240),
            Step(order: 10, instruction: "Add capsicum and cook on high for 1–2 minutes.", timerSeconds: 90),
            Step(order: 11, instruction: "Strain the base gravy directly into the pan. Stir well and cook on high for 5 minutes. Taste, adjust seasoning, and add the pinch of sugar.", tip: "Straining gives the dish its silky, restaurant-style texture.", timerSeconds: 300),
            Step(order: 12, instruction: "Add sautéed paneer, fresh cream, butter, kasuri methi powder, garam masala, and grated paneer. Stir well. Finish with fresh coriander and serve hot with naan or roti.", tip: "Grated paneer at the end naturally thickens and enriches the gravy.")
        ]
    )

    // MARK: - Chia Puddings

    static let baseChiaPudding = Recipe(
        name: "Base Chia Pudding",
        cuisine: "Healthy",
        difficulty: .easy,
        totalMinutes: 125,
        defaultServings: 1,
        sfSymbol: "circle.grid.2x2.fill",
        accentHex: "6B7280",
        isMultiDish: false,
        mealType: .breakfast,
        ingredients: [
            Ingredient(name: "Chia seeds", amount: 2, unit: "tbsp"),
            Ingredient(name: "Milk", amount: 0.5, unit: "cup"),
            Ingredient(name: "Maple syrup", amount: 1.5, unit: "tsp")
        ],
        steps: [
            Step(order: 1, instruction: "Add chia seeds, milk, and maple syrup to a jar. Mix well."),
            Step(order: 2, instruction: "Let sit for 5 minutes, then stir again to break up any clumps.", timerSeconds: 300),
            Step(order: 3, instruction: "Cover with a lid and refrigerate for at least 2 hours.", tip: "Store in the fridge for up to 5 days, or freeze for 3–4 weeks.", timerSeconds: 7200),
            Step(order: 4, instruction: "Serve as-is, or top with fruits, berries, or nuts.")
        ]
    )

    static let mangoCoconutChia = Recipe(
        name: "Mango Coconut Chia Pudding",
        cuisine: "Healthy",
        difficulty: .easy,
        totalMinutes: 130,
        defaultServings: 1,
        sfSymbol: "sun.max.fill",
        accentHex: "F59E0B",
        isMultiDish: false,
        mealType: .breakfast,
        ingredients: [
            Ingredient(name: "Canned light coconut milk", amount: 0.5, unit: "cup"),
            Ingredient(name: "Chia seeds", amount: 2, unit: "tbsp"),
            Ingredient(name: "Maple syrup", amount: 1.5, unit: "tsp"),
            Ingredient(name: "Vanilla extract", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Ripe mango", amount: 1, unit: "no."),
            Ingredient(name: "Coconut flakes (topping)", amount: 1, unit: "tbsp")
        ],
        steps: [
            Step(order: 1, instruction: "Mix coconut milk, chia seeds, maple syrup, and vanilla extract in a jar."),
            Step(order: 2, instruction: "Let sit for 5 minutes, then stir again to break up any clumps.", timerSeconds: 300),
            Step(order: 3, instruction: "Cover and refrigerate for at least 2 hours.", tip: "Store in the fridge for up to 5 days, or freeze for 3–4 weeks.", timerSeconds: 7200),
            Step(order: 4, instruction: "Peel the mango and cut into small chunks. Reserve a few chunks for topping, then blend the rest into a smooth puree."),
            Step(order: 5, instruction: "In a jar, add alternating layers of chia pudding and mango puree. Top with mango chunks and coconut flakes.")
        ]
    )

    static let orangeCreamsicleChia = Recipe(
        name: "Orange Creamsicle Chia Pudding",
        cuisine: "Healthy",
        difficulty: .easy,
        totalMinutes: 130,
        defaultServings: 1,
        sfSymbol: "sunrise.fill",
        accentHex: "F97316",
        isMultiDish: false,
        mealType: .breakfast,
        ingredients: [
            Ingredient(name: "Mandarins", amount: 3, unit: "nos."),
            Ingredient(name: "Canned light coconut milk", amount: 0.25, unit: "cup"),
            Ingredient(name: "Chia seeds", amount: 2, unit: "tbsp"),
            Ingredient(name: "Maple syrup", amount: 1.5, unit: "tsp"),
            Ingredient(name: "Vanilla extract", amount: 1, unit: "tsp"),
            Ingredient(name: "Greek yogurt (topping)", amount: 1, unit: "tbsp"),
            Ingredient(name: "Coconut flakes (topping)", amount: 1, unit: "tbsp"),
            Ingredient(name: "Mandarin slices (topping)", amount: 3, unit: "slices")
        ],
        steps: [
            Step(order: 1, instruction: "Squeeze the mandarins to get 3 tbsp of juice."),
            Step(order: 2, instruction: "Mix mandarin juice, coconut milk, chia seeds, maple syrup, and vanilla in a jar."),
            Step(order: 3, instruction: "Let sit for 5 minutes, then stir again to break up any clumps.", timerSeconds: 300),
            Step(order: 4, instruction: "Cover and refrigerate for at least 2 hours.", tip: "Store in the fridge for up to 5 days, or freeze for 3–4 weeks.", timerSeconds: 7200),
            Step(order: 5, instruction: "Top with a spoonful of Greek yogurt, mandarin slices, and coconut flakes. Finish by grating orange zest over the top.")
        ]
    )

    static let veryBerryChia = Recipe(
        name: "Very Berry Chia Pudding",
        cuisine: "Healthy",
        difficulty: .easy,
        totalMinutes: 130,
        defaultServings: 1,
        sfSymbol: "leaf.fill",
        accentHex: "7C3AED",
        isMultiDish: false,
        mealType: .breakfast,
        ingredients: [
            Ingredient(name: "Chia seeds", amount: 2, unit: "tbsp"),
            Ingredient(name: "Milk", amount: 0.5, unit: "cup"),
            Ingredient(name: "Maple syrup", amount: 1.5, unit: "tsp"),
            Ingredient(name: "Frozen berries", amount: 0.5, unit: "cup"),
            Ingredient(name: "Fresh berries (topping)", amount: 1, unit: "handful"),
            Ingredient(name: "Granola (topping)", amount: 2, unit: "tbsp"),
            Ingredient(name: "Hemp hearts (topping)", amount: 1, unit: "tsp")
        ],
        steps: [
            Step(order: 1, instruction: "Blend milk, maple syrup, and frozen berries until completely smooth."),
            Step(order: 2, instruction: "Combine the blended mixture with chia seeds in a jar and stir well."),
            Step(order: 3, instruction: "Let sit for 5 minutes, then stir again to break up any clumps.", timerSeconds: 300),
            Step(order: 4, instruction: "Cover and refrigerate for at least 2 hours.", tip: "Store in the fridge for up to 5 days, or freeze for 3–4 weeks.", timerSeconds: 7200),
            Step(order: 5, instruction: "Add toppings: fresh berries, granola, and hemp hearts.")
        ]
    )

    static let applePieChia = Recipe(
        name: "Apple Pie Chia Pudding",
        cuisine: "Healthy",
        difficulty: .easy,
        totalMinutes: 135,
        defaultServings: 1,
        sfSymbol: "fork.knife",
        accentHex: "DC2626",
        isMultiDish: false,
        mealType: .breakfast,
        ingredients: [
            Ingredient(name: "Chia seeds", amount: 2, unit: "tbsp"),
            Ingredient(name: "Almond milk", amount: 0.5, unit: "cup"),
            Ingredient(name: "Maple syrup", amount: 1.5, unit: "tsp"),
            Ingredient(name: "Apple sauce", amount: 1, unit: "tbsp"),
            Ingredient(name: "Cinnamon", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Red apple", amount: 0.5, unit: "no."),
            Ingredient(name: "Coconut oil", amount: 1, unit: "tsp"),
            Ingredient(name: "Maple syrup (for apple)", amount: 1.5, unit: "tsp"),
            Ingredient(name: "Cinnamon (for apple)", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Cinnamon (topping)", amount: 1, unit: "pinch")
        ],
        steps: [
            Step(order: 1, instruction: "Mix chia seeds, almond milk, maple syrup, apple sauce, and cinnamon in a jar."),
            Step(order: 2, instruction: "Let sit for 5 minutes, then stir again to break up any clumps.", timerSeconds: 300),
            Step(order: 3, instruction: "Cover and refrigerate for at least 2 hours.", tip: "Store in the fridge for up to 5 days, or freeze for 3–4 weeks.", timerSeconds: 7200),
            Step(order: 4, instruction: "Chop apple into small cubes. Cook with coconut oil, maple syrup, and cinnamon in a saucepan over medium heat for 4–5 minutes until caramelized.", timerSeconds: 300),
            Step(order: 5, instruction: "Spoon caramelized apple chunks on top of the chia pudding and finish with a pinch of cinnamon.")
        ]
    )

    static let pumpkinSpiceChia = Recipe(
        name: "Pumpkin Spice Chia Pudding",
        cuisine: "Healthy",
        difficulty: .easy,
        totalMinutes: 125,
        defaultServings: 1,
        sfSymbol: "flame.fill",
        accentHex: "EA580C",
        isMultiDish: false,
        mealType: .breakfast,
        ingredients: [
            Ingredient(name: "Chia seeds", amount: 2, unit: "tbsp"),
            Ingredient(name: "Milk", amount: 0.5, unit: "cup"),
            Ingredient(name: "Maple syrup", amount: 1.5, unit: "tsp"),
            Ingredient(name: "Pure pumpkin puree", amount: 2, unit: "tbsp"),
            Ingredient(name: "Pumpkin pie spice", amount: 1, unit: "tsp"),
            Ingredient(name: "Vanilla extract", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Greek yogurt (topping)", amount: 1, unit: "tbsp"),
            Ingredient(name: "Cinnamon (topping)", amount: 1, unit: "pinch")
        ],
        steps: [
            Step(order: 1, instruction: "Mix chia seeds, milk, maple syrup, pumpkin puree, pumpkin pie spice, and vanilla in a jar."),
            Step(order: 2, instruction: "Let sit for 5 minutes, then stir again to break up any clumps.", timerSeconds: 300),
            Step(order: 3, instruction: "Cover and refrigerate for at least 2 hours.", tip: "Store in the fridge for up to 5 days, or freeze for 3–4 weeks.", timerSeconds: 7200),
            Step(order: 4, instruction: "Add toppings: a spoonful of Greek yogurt and a pinch of cinnamon.")
        ]
    )

    static let chocolateBananaChia = Recipe(
        name: "Chocolate Banana Chia Pudding",
        cuisine: "Healthy",
        difficulty: .easy,
        totalMinutes: 125,
        defaultServings: 1,
        sfSymbol: "cup.and.saucer.fill",
        accentHex: "78350F",
        isMultiDish: false,
        mealType: .breakfast,
        ingredients: [
            Ingredient(name: "Chia seeds", amount: 2, unit: "tbsp"),
            Ingredient(name: "Almond milk", amount: 0.5, unit: "cup"),
            Ingredient(name: "Maple syrup", amount: 1.5, unit: "tsp"),
            Ingredient(name: "Cocoa powder", amount: 1, unit: "tbsp"),
            Ingredient(name: "Vanilla extract", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Chocolate chips", amount: 1, unit: "tbsp"),
            Ingredient(name: "Banana (topping)", amount: 1, unit: "no."),
            Ingredient(name: "Chocolate chips (topping)", amount: 1, unit: "tbsp"),
            Ingredient(name: "Crushed almonds (topping)", amount: 1, unit: "tbsp")
        ],
        steps: [
            Step(order: 1, instruction: "Mix chia seeds, almond milk, maple syrup, cocoa powder, vanilla, and chocolate chips in a jar."),
            Step(order: 2, instruction: "Let sit for 5 minutes, then stir again to break up any clumps.", timerSeconds: 300),
            Step(order: 3, instruction: "Cover and refrigerate for at least 2 hours.", tip: "Store in the fridge for up to 5 days, or freeze for 3–4 weeks.", timerSeconds: 7200),
            Step(order: 4, instruction: "Slice the banana and add on top along with chocolate chips and crushed almonds.")
        ]
    )
}
