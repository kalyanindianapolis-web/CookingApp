import Foundation

enum SeedRecipes {
    static let all: [Recipe] = [
        dalTadka, jeeraRice, bagaraRice, chanaMasala, alooGobi,
        paneerDahiSandwich, paneer, kajuMasala, rajmaMasala,
        paniPuriPani, masalaPuri, chiaPudding
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
        ],
        imageName: "recipe_dal_tadka"
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
        ],
        imageName: "recipe_jeera_rice"
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
        ],
        imageName: "recipe_bagara_rice"
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
        ],
        imageName: "recipe_chana_masala"
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
        ],
        imageName: "recipe_aloo_gobi"
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
        ],
        imageName: "recipe_paneer_sandwich"
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

    // MARK: - Paneer (grouped)

    static let paneer = Recipe(
        name: "Paneer",
        cuisine: "North Indian",
        difficulty: .medium,
        totalMinutes: 45,
        defaultServings: 5,
        sfSymbol: "crown.fill",
        accentHex: "E53935",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: paneerLababdar.ingredients,
        steps: paneerLababdar.steps,
        variations: [
            RecipeVariation(
                name: "Butter Masala",
                accentHex: "FF6D00",
                totalMinutes: 40,
                ingredients: [
                    // Paste
                    Ingredient(name: "Tomatoes (for paste)", amount: 4, unit: "nos."),
                    Ingredient(name: "Garlic (for paste)", amount: 9, unit: "cloves"),
                    Ingredient(name: "Ginger (for paste)", amount: 1, unit: "inch piece"),
                    Ingredient(name: "Coriander stems", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Green chilli (for paste)", amount: 1, unit: "no."),
                    Ingredient(name: "Kashmiri red chilli powder (paste)", amount: 1.5, unit: "tbsp"),
                    Ingredient(name: "Coriander powder", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Cumin powder", amount: 0.5, unit: "tsp"),
                    Ingredient(name: "Cashews (soaked)", amount: 15, unit: "nos."),
                    // Sautéed paneer
                    Ingredient(name: "Oil (paneer)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Butter (paneer)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Paneer (cubed)", amount: 500, unit: "g"),
                    Ingredient(name: "Kashmiri red chilli powder (paneer)", amount: 1, unit: "pinch"),
                    // Gravy
                    Ingredient(name: "Oil (gravy)", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Butter (gravy)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
                    Ingredient(name: "Green cardamom", amount: 3, unit: "nos."),
                    Ingredient(name: "Cinnamon", amount: 0.5, unit: "inch piece"),
                    Ingredient(name: "Bay leaf", amount: 1, unit: "no."),
                    Ingredient(name: "Garlic (chopped)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Green chilli (chopped)", amount: 1, unit: "no."),
                    Ingredient(name: "Onion (chopped)", amount: 3, unit: "medium"),
                    Ingredient(name: "Turmeric powder", amount: 0.25, unit: "tsp"),
                    Ingredient(name: "Kashmiri red chilli powder (gravy)", amount: 0.5, unit: "tsp"),
                    Ingredient(name: "Salt", amount: 1, unit: "to taste"),
                    Ingredient(name: "Sugar", amount: 1, unit: "pinch"),
                    Ingredient(name: "Butter (finishing)", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Roasted kasuri methi powder", amount: 1, unit: "pinch"),
                    Ingredient(name: "Garam masala", amount: 1, unit: "pinch"),
                    Ingredient(name: "Fresh cream", amount: 3.5, unit: "tbsp"),
                    Ingredient(name: "Fresh coriander (chopped)", amount: 1, unit: "handful")
                ],
                steps: [
                    Step(order: 1, instruction: "Soak cashews in boiling water for 10–15 minutes.", timerSeconds: 750),
                    Step(order: 2, instruction: "Add all paste ingredients (tomatoes, garlic, ginger, coriander stems, green chilli, Kashmiri chilli powder, coriander powder, cumin powder, soaked cashews) to a blender. Grind into a fine, smooth paste. Set aside.", tip: "Drain the cashews before adding — excess water makes the paste thin."),
                    Step(order: 3, instruction: "Heat a pan on high. Add oil and butter. Once hot, add paneer cubes with a pinch of salt and Kashmiri chilli powder. Toss on high flame for 1–2 minutes until lightly golden. Remove and set aside.", tip: "Sautéing the paneer first helps it hold its shape in the gravy.", timerSeconds: 90),
                    Step(order: 4, instruction: "Heat a wok or kadhai. Add oil and butter. Once hot, add cumin seeds, cardamom, cinnamon, and bay leaf. Add chopped garlic and green chilli. Add onions and cook on medium-high until light golden brown.", timerSeconds: 480),
                    Step(order: 5, instruction: "Add turmeric and Kashmiri red chilli powder. Splash in hot water, stir, and cook the masala for 2–3 minutes.", timerSeconds: 150),
                    Step(order: 6, instruction: "Add the prepared paste, salt, and sugar. Stir well and cook on medium-high until the oil separates.", tip: "Keep stirring — the paste will spit as it cooks down.", timerSeconds: 480),
                    Step(order: 7, instruction: "Add hot water to adjust gravy consistency. Cook for 2–3 minutes. Taste and adjust seasoning.", timerSeconds: 150),
                    Step(order: 8, instruction: "Add sautéed paneer, butter, roasted kasuri methi powder, garam masala, and fresh cream. Stir gently and cook for just 1–2 minutes. Finish with fresh coriander.", timerSeconds: 90),
                    Step(order: 9, instruction: "Serve hot with naan, tandoori roti, or rumali roti.")
                ],
                imageName: "recipe_paneer_butter_masala"
            ),
            RecipeVariation(
                name: "Chilli",
                accentHex: "2E7D32",
                totalMinutes: 35,
                ingredients: [
                    Ingredient(name: "Paneer (cubed)", amount: 250, unit: "g"),
                    Ingredient(name: "Salt & black pepper", amount: 1, unit: "to taste"),
                    Ingredient(name: "Cornstarch (coating)", amount: 0.25, unit: "cup"),
                    Ingredient(name: "Oil (for frying)", amount: 3, unit: "tbsp"),
                    Ingredient(name: "Garlic (chopped)", amount: 14, unit: "cloves"),
                    Ingredient(name: "Ginger (chopped)", amount: 1, unit: "inch piece"),
                    Ingredient(name: "Green chillies (slit)", amount: 9, unit: "nos."),
                    Ingredient(name: "Spring onion bulbs", amount: 6, unit: "stalks"),
                    Ingredient(name: "Capsicum (diced)", amount: 2, unit: "medium"),
                    Ingredient(name: "Spring onion greens (chopped)", amount: 0.25, unit: "cup"),
                    Ingredient(name: "Sugar", amount: 1, unit: "tsp"),
                    Ingredient(name: "Soy sauce", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Red chilli sauce", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Cornflour (sauce)", amount: 5, unit: "tbsp"),
                    Ingredient(name: "Water (for cornflour)", amount: 100, unit: "ml"),
                    Ingredient(name: "Spring onion greens (garnish)", amount: 1, unit: "handful")
                ],
                steps: [
                    Step(order: 1, instruction: "In a mixing bowl, toss paneer cubes with salt, black pepper, and cornstarch until evenly coated."),
                    Step(order: 2, instruction: "Set a pan on medium heat, add oil and shallow fry the coated paneer on all sides until golden brown. Remove and set aside.", timerSeconds: 300),
                    Step(order: 3, instruction: "Set the same pan on high heat. Add a little more oil, then add garlic, ginger, green chillies, and spring onion bulbs. Sauté on high flame for 3–4 minutes.", timerSeconds: 240),
                    Step(order: 4, instruction: "Add capsicum, spring onion greens, and sugar. Sauté for 1 minute.", timerSeconds: 60),
                    Step(order: 5, instruction: "Add soy sauce and red chilli sauce. Sauté for 1 minute.", timerSeconds: 60),
                    Step(order: 6, instruction: "Mix cornflour with 100 ml water until smooth. Pour into the pan, season with salt and black pepper, and cook until the sauce thickens.", tip: "Keep stirring as you add the cornflour mixture to avoid lumps.", timerSeconds: 120),
                    Step(order: 7, instruction: "Add the fried paneer and mix gently to coat well with the sauce."),
                    Step(order: 8, instruction: "Finish with freshly chopped spring onion greens and take off the heat immediately. Serve as a party appetizer with schezwan sauce on the side.", tip: "Paneer Chilli must be eaten immediately — it loses its texture as it sits.")
                ],
                imageName: "recipe_paneer_chilli"
            ),
            RecipeVariation(
                name: "Makhani Burger",
                accentHex: "B45309",
                totalMinutes: 70,
                ingredients: [
                    // Makhani puree
                    Ingredient(name: "Oil (puree)", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
                    Ingredient(name: "Onions (sliced)", amount: 3, unit: "medium"),
                    Ingredient(name: "Garlic (puree)", amount: 11, unit: "cloves"),
                    Ingredient(name: "Ginger (puree)", amount: 1, unit: "inch piece"),
                    Ingredient(name: "Green chillies (puree)", amount: 2, unit: "nos."),
                    Ingredient(name: "Green cardamom", amount: 2, unit: "pods"),
                    Ingredient(name: "Bay leaf", amount: 2, unit: "nos."),
                    Ingredient(name: "Coriander stems", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Kashmiri red chillies (whole)", amount: 8, unit: "nos."),
                    Ingredient(name: "Tomatoes (chopped)", amount: 8, unit: "nos."),
                    Ingredient(name: "Cashew nuts", amount: 11, unit: "nos."),
                    Ingredient(name: "Turmeric powder", amount: 0.25, unit: "tsp"),
                    Ingredient(name: "Kashmiri red chilli powder (puree)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Coriander powder (puree)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Hot water (puree)", amount: 350, unit: "ml"),
                    // Tadka
                    Ingredient(name: "Butter (tadka)", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Oil (tadka)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Garlic (chopped, tadka)", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Ginger (julienne, tadka)", amount: 1, unit: "inch piece"),
                    Ingredient(name: "Green chillies (chopped, tadka)", amount: 1, unit: "no."),
                    Ingredient(name: "Kashmiri red chilli powder (tadka)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Garam masala", amount: 1, unit: "pinch"),
                    Ingredient(name: "Kasuri methi powder", amount: 1, unit: "pinch"),
                    Ingredient(name: "Honey", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Fresh cream", amount: 2.5, unit: "tbsp"),
                    Ingredient(name: "Fresh coriander", amount: 1, unit: "small handful"),
                    // Paneer patty batter
                    Ingredient(name: "Refined flour (maida)", amount: 0.5, unit: "cup"),
                    Ingredient(name: "Cornflour (batter)", amount: 3, unit: "tbsp"),
                    Ingredient(name: "Ginger garlic paste", amount: 1, unit: "tsp"),
                    Ingredient(name: "Kashmiri red chilli powder (batter)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Coriander powder (batter)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Cumin powder", amount: 1, unit: "tsp"),
                    Ingredient(name: "Dry mango powder (amchur)", amount: 0.5, unit: "tsp"),
                    Ingredient(name: "Black salt", amount: 0.5, unit: "tsp"),
                    Ingredient(name: "Garam masala (batter)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Kasuri methi (batter)", amount: 0.25, unit: "tsp"),
                    Ingredient(name: "Paneer", amount: 500, unit: "g"),
                    Ingredient(name: "Panko breadcrumbs", amount: 1, unit: "cup"),
                    Ingredient(name: "Oil for deep frying", amount: 1, unit: "as needed"),
                    // Assembly
                    Ingredient(name: "Burger buns (toasted)", amount: 6, unit: "nos."),
                    Ingredient(name: "Mint mayo", amount: 1, unit: "as needed"),
                    Ingredient(name: "Romaine lettuce", amount: 1, unit: "as needed"),
                    Ingredient(name: "Onion rings", amount: 1, unit: "as needed"),
                    Ingredient(name: "Salt", amount: 1, unit: "to taste")
                ],
                steps: [
                    Step(order: 1, instruction: "For the makhani puree: heat oil in a wok on medium-high. Add cumin seeds and sliced onions. Cook on high until light golden brown."),
                    Step(order: 2, instruction: "Add garlic, ginger, green chillies, cardamom, bay leaves, coriander stems, whole Kashmiri red chillies, chopped tomatoes, salt, cashews, turmeric, chilli powder, and coriander powder. Stir and cook on medium-high for 15–18 minutes until tomatoes are completely mushy. Cover to speed it up.", tip: "Don't add water until the tomatoes break down on their own — it concentrates the flavour.", timerSeconds: 1080),
                    Step(order: 3, instruction: "Add hot water, lower the flame, cover and cook for 10 more minutes.", timerSeconds: 600),
                    Step(order: 4, instruction: "Cool to room temperature. Blend into a fine paste using minimal water. Strain through a sieve. Set aside.", tip: "Cool completely before blending — hot liquid in a blender can splash dangerously."),
                    Step(order: 5, instruction: "For the tadka: heat butter and oil in a pan. Add chopped garlic, ginger julienne, and green chillies. Cook on high for 1–2 minutes.", timerSeconds: 90),
                    Step(order: 6, instruction: "Lower the flame. Add Kashmiri red chilli powder and stir quickly. Add the strained makhani puree. Cook for 5–6 minutes.", timerSeconds: 360),
                    Step(order: 7, instruction: "Add hot water if needed to reach a thick, spreadable sauce consistency. Add garam masala, kasuri methi, honey, cream, and fresh coriander. Stir well. Taste and adjust salt. Set aside.", tip: "The sauce should coat a spoon — not drip like water, not stick like paste."),
                    Step(order: 8, instruction: "For the patty: mix refined flour, cornflour, ginger garlic paste, all spices (chilli powder, coriander, cumin, amchur, black salt, garam masala, kasuri methi), and oil. Add water gradually and whisk into a smooth, lump-free batter."),
                    Step(order: 9, instruction: "Season breadcrumbs with salt. Cut paneer into slabs less than 1 cm thick. Dip each slab in batter, let excess drip off, then coat evenly in breadcrumbs."),
                    Step(order: 10, instruction: "Heat oil in a wok for deep frying. Fry coated paneer on medium-high until crisp and golden brown. Drain on a wire sieve.", timerSeconds: 300),
                    Step(order: 11, instruction: "Toast the burger buns. Spread mint mayo on the bottom bun. Layer with romaine lettuce, the crispy paneer patty, a generous spoonful of makhani sauce, and onion rings. Cap and serve immediately.")
                ],
                imageName: "recipe_paneer_makhani_burger"
            ),
            RecipeVariation(
                name: "Spicy Burger",
                accentHex: "B91C1C",
                totalMinutes: 35,
                ingredients: [
                    // Sweet & spicy mayo
                    Ingredient(name: "Mayonnaise", amount: 0.75, unit: "cup"),
                    Ingredient(name: "Tomato ketchup", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Red chilli sauce", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Garlic (chopped)", amount: 0.25, unit: "tsp"),
                    // Spicy paneer patty
                    Ingredient(name: "Paneer", amount: 500, unit: "g"),
                    Ingredient(name: "Refined flour (maida)", amount: 0.5, unit: "cup"),
                    Ingredient(name: "Red chilli powder", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Green chilli paste", amount: 1, unit: "tsp"),
                    Ingredient(name: "Ginger garlic paste", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Amchur powder", amount: 1, unit: "tsp"),
                    Ingredient(name: "Garam masala", amount: 1, unit: "pinch"),
                    Ingredient(name: "Salt & black pepper", amount: 1, unit: "to taste"),
                    Ingredient(name: "Breadcrumbs", amount: 1, unit: "cup"),
                    Ingredient(name: "Oil for deep frying", amount: 1, unit: "as needed"),
                    // Assembly
                    Ingredient(name: "Burger buns", amount: 1, unit: "as needed"),
                    Ingredient(name: "Butter (for toasting)", amount: 1, unit: "as needed"),
                    Ingredient(name: "Romaine lettuce", amount: 1, unit: "as needed")
                ],
                steps: [
                    Step(order: 1, instruction: "Make the sweet & spicy mayo: mix mayonnaise, red chilli sauce, tomato ketchup, and chopped garlic in a bowl until smooth. Set aside."),
                    Step(order: 2, instruction: "Cut paneer into 4 cm × 6 cm rectangle slabs. Adjust thickness to your preference."),
                    Step(order: 3, instruction: "In a mixing bowl, combine refined flour, red chilli powder, green chilli paste, ginger garlic paste, amchur powder, garam masala, and salt & pepper. Add water gradually and mix into a thick, lump-free batter."),
                    Step(order: 4, instruction: "Season breadcrumbs with salt & black pepper. Dip paneer slabs in the batter, let excess drip off, then coat well with the seasoned breadcrumbs."),
                    Step(order: 5, instruction: "Heat oil in a pan on medium-high. Deep fry the coated paneer until crisp and golden brown. Do not overcrowd the pan. Drain on absorbent paper.", timerSeconds: 300),
                    Step(order: 6, instruction: "Slice burger buns in half and toast using butter on the inside (cut side only) until golden."),
                    Step(order: 7, instruction: "Spread sweet & spicy mayo generously on the bottom bun. Add romaine lettuce, place the crispy paneer patty on top, and close with the top bun. Serve hot with mildly seasoned fries.", tip: "Add a cheese slice before closing for an extra indulgent burger.")
                ],
                imageName: "recipe_paneer_spicy_burger"
            ),
            RecipeVariation(
                name: "Do Pyaaza",
                accentHex: "A16207",
                totalMinutes: 40,
                ingredients: [
                    // Shallow frying paneer
                    Ingredient(name: "Paneer", amount: 750, unit: "g"),
                    Ingredient(name: "Oil for shallow frying", amount: 1, unit: "as needed"),
                    // Gravy
                    Ingredient(name: "Ghee", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Oil (gravy)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
                    Ingredient(name: "Bay leaves", amount: 2, unit: "nos."),
                    Ingredient(name: "Cinnamon stick", amount: 1, unit: "inch piece"),
                    Ingredient(name: "Green cardamom", amount: 2, unit: "nos."),
                    Ingredient(name: "Cloves", amount: 3, unit: "nos."),
                    Ingredient(name: "Black peppercorns", amount: 3, unit: "nos."),
                    Ingredient(name: "Black cardamom (badi elaichi)", amount: 1, unit: "no."),
                    Ingredient(name: "Asafoetida (hing)", amount: 0.5, unit: "tsp"),
                    Ingredient(name: "Onions (sliced)", amount: 5, unit: "medium"),
                    Ingredient(name: "Ginger garlic paste", amount: 3, unit: "tbsp"),
                    Ingredient(name: "Turmeric powder", amount: 1, unit: "tsp"),
                    Ingredient(name: "Tomatoes (chopped)", amount: 4, unit: "medium"),
                    Ingredient(name: "Salt", amount: 1, unit: "to taste"),
                    Ingredient(name: "Curd", amount: 0.5, unit: "cup"),
                    Ingredient(name: "Red chilli powder", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Coriander powder", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Fennel powder", amount: 1, unit: "tsp"),
                    Ingredient(name: "Cumin powder", amount: 1, unit: "tsp"),
                    Ingredient(name: "Garam masala", amount: 1, unit: "tsp"),
                    Ingredient(name: "Kasuri methi", amount: 1, unit: "tsp"),
                    // Tempering
                    Ingredient(name: "Ghee (tempering)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Jeera (tempering)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Coriander seeds (crushed)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Green chillies (slit)", amount: 2, unit: "nos."),
                    Ingredient(name: "Dry Kashmiri red chillies", amount: 1, unit: "no."),
                    Ingredient(name: "Garam masala (tempering)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Onion petals", amount: 0.5, unit: "cup"),
                    Ingredient(name: "Fresh coriander leaves", amount: 1, unit: "tbsp")
                ],
                steps: [
                    Step(order: 1, instruction: "Cut paneer into 4 × 4 cm slabs or cubes. Shallow fry in oil until golden brown and crisp on both sides. Transfer immediately to salted lukewarm water and soak for 10 minutes.", timerSeconds: 600),
                    Step(order: 2, instruction: "Set a wok on medium heat. Add ghee, oil, and all whole spices (cumin, bay leaves, cinnamon, cardamom, cloves, peppercorns, black cardamom). Sauté for a minute. Add hing and sliced onions. Cook until onions are almost golden brown."),
                    Step(order: 3, instruction: "Add ginger garlic paste and cook until the onions turn fully golden brown. Add turmeric powder and cook for a minute.", timerSeconds: 300),
                    Step(order: 4, instruction: "Add tomatoes and salt. Cook until completely mushy and the ghee separates from the masala.", timerSeconds: 480),
                    Step(order: 5, instruction: "In a separate bowl, mix curd with red chilli powder, coriander powder, fennel powder, and cumin powder. Lower the flame to low. Add the curd mixture to the wok and stir continuously for 2–3 minutes. Cook on medium-low until curd is cooked and ghee separates.", tip: "Lower the flame before adding curd to prevent it from splitting.", timerSeconds: 180),
                    Step(order: 6, instruction: "Add hot water to adjust gravy consistency. Bring to a boil and simmer for 3–4 minutes.", timerSeconds: 240),
                    Step(order: 7, instruction: "Drain the soaked paneer and add to the gravy. Mix gently. Add garam masala and kasuri methi. Cook for 1–2 minutes.", timerSeconds: 90),
                    Step(order: 8, instruction: "For tempering: heat ghee in a small tadka pan. Add jeera, crushed coriander seeds, dry Kashmiri red chilli, onion petals, slit green chillies, and garam masala. Sauté for 1 minute. Pour the tempering immediately over the paneer gravy.", timerSeconds: 60),
                    Step(order: 9, instruction: "Stir gently, cover, and cook on low-medium heat for 1–2 minutes. Finish with fresh coriander. Serve hot with laccha paratha, roti, or any Indian bread.", timerSeconds: 90)
                ],
                imageName: "recipe_paneer_do_pyaaza"
            ),
            RecipeVariation(
                name: "Palak",
                accentHex: "15803D",
                totalMinutes: 45,
                ingredients: [
                    Ingredient(name: "Spinach", amount: 1, unit: "big bunch"),
                    Ingredient(name: "Oil (for masala)", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Cloves", amount: 4, unit: "nos."),
                    Ingredient(name: "Bay leaf", amount: 2, unit: "nos."),
                    Ingredient(name: "Green cardamom", amount: 3, unit: "nos."),
                    Ingredient(name: "Cinnamon stick", amount: 1, unit: "inch piece"),
                    Ingredient(name: "Black cardamom", amount: 1, unit: "no."),
                    Ingredient(name: "Garlic cloves", amount: 7, unit: "nos."),
                    Ingredient(name: "Ginger", amount: 1, unit: "inch piece"),
                    Ingredient(name: "Green chillies", amount: 2, unit: "nos."),
                    Ingredient(name: "Onion (sliced)", amount: 2, unit: "medium"),
                    Ingredient(name: "Tomatoes", amount: 2, unit: "medium"),
                    Ingredient(name: "Salt", amount: 1, unit: "to taste"),
                    Ingredient(name: "Fresh coriander", amount: 0.5, unit: "cup"),
                    Ingredient(name: "Oil (for final cooking)", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Jeera (cumin seeds)", amount: 1, unit: "tsp"),
                    Ingredient(name: "Ginger (julienne)", amount: 1, unit: "inch piece"),
                    Ingredient(name: "Red chilli powder", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Coriander powder", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Turmeric powder", amount: 0.5, unit: "tsp"),
                    Ingredient(name: "Curd", amount: 3, unit: "tbsp"),
                    Ingredient(name: "Paneer (cubed)", amount: 450, unit: "g"),
                    Ingredient(name: "Paneer (grated)", amount: 50, unit: "g"),
                    Ingredient(name: "Garam masala", amount: 1, unit: "tsp"),
                    Ingredient(name: "Kasuri methi", amount: 1, unit: "tsp")
                ],
                steps: [
                    Step(order: 1, instruction: "Blanch the entire bunch of spinach in boiling water for 2 minutes. Immediately transfer to ice-cold water to stop cooking and preserve the colour. Drain and set aside.", tip: "The ice bath locks in the vivid green colour of the spinach.", timerSeconds: 120),
                    Step(order: 2, instruction: "Heat 2 tbsp oil in a wok. Add whole spices (cloves, bay leaves, cardamom, cinnamon, black cardamom) and sauté for 1 minute. Add garlic, ginger, green chillies, and sliced onions. Cook until onions are translucent.", timerSeconds: 300),
                    Step(order: 3, instruction: "Add tomatoes and salt. Cook until completely mushy.", timerSeconds: 300),
                    Step(order: 4, instruction: "Add fresh coriander and the blanched spinach. Mix well and cook for 2–3 minutes. Add a splash of water to cool slightly, then blend the entire mixture into a fine, smooth paste.", timerSeconds: 180),
                    Step(order: 5, instruction: "Heat 1 tbsp oil in a wok. Add jeera and let it splutter. Add ginger julienne and sauté for 1 minute. Add the spinach paste and mix well.", timerSeconds: 60),
                    Step(order: 6, instruction: "Add red chilli powder, coriander powder, and turmeric. Stir and cook on low flame for 2–3 minutes.", timerSeconds: 180),
                    Step(order: 7, instruction: "Add curd and stir continuously without stopping the moment it goes in. Cover and cook until the oil releases, stirring occasionally. Add water to adjust gravy consistency.", tip: "Stir immediately after adding curd so it blends in without splitting.", timerSeconds: 360),
                    Step(order: 8, instruction: "Add the paneer cubes to the gravy and mix gently without breaking them. Add the grated paneer, stir, and cook for 2–3 minutes.", timerSeconds: 180),
                    Step(order: 9, instruction: "Add garam masala and kasuri methi. Taste and adjust salt. Serve hot with naan, roti, or rice.")
                ],
                imageName: "recipe_palak_paneer"
            ),
            RecipeVariation(
                name: "Kaju Masala",
                accentHex: "CA8A04",
                totalMinutes: 50,
                ingredients: [
                    Ingredient(name: "Cashews (for puree, soaked)", amount: 22, unit: "nos."),
                    Ingredient(name: "Cashews (for frying)", amount: 32, unit: "nos."),
                    Ingredient(name: "Ghee", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Paneer (cubed)", amount: 350, unit: "g"),
                    Ingredient(name: "Tomato (roughly chopped)", amount: 1, unit: "no."),
                    Ingredient(name: "Oil", amount: 1.5, unit: "tbsp"),
                    Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
                    Ingredient(name: "Bay leaf", amount: 1, unit: "no."),
                    Ingredient(name: "Green cardamom", amount: 2, unit: "nos."),
                    Ingredient(name: "Cinnamon", amount: 2, unit: "inch piece"),
                    Ingredient(name: "Onion (chopped)", amount: 4, unit: "medium"),
                    Ingredient(name: "Ginger garlic green chilli paste", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Turmeric powder", amount: 0.25, unit: "tsp"),
                    Ingredient(name: "Kashmiri red chilli powder", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Spicy red chilli powder", amount: 2, unit: "tsp"),
                    Ingredient(name: "Coriander powder", amount: 2, unit: "tbsp"),
                    Ingredient(name: "Cumin powder", amount: 1, unit: "tsp"),
                    Ingredient(name: "Coriander stems", amount: 1, unit: "tbsp"),
                    Ingredient(name: "Curd (whisked)", amount: 0.5, unit: "cup"),
                    Ingredient(name: "Salt", amount: 1, unit: "to taste"),
                    Ingredient(name: "Green chilli (slit)", amount: 2, unit: "nos."),
                    Ingredient(name: "Ginger julienne", amount: 1, unit: "handful"),
                    Ingredient(name: "Garam masala", amount: 1, unit: "pinch"),
                    Ingredient(name: "Roasted kasuri methi powder", amount: 1, unit: "pinch"),
                    Ingredient(name: "Fresh coriander", amount: 1, unit: "handful")
                ],
                steps: [
                    Step(order: 1, instruction: "Soak 20–25 cashews in hot water, cover and set aside while you do the next steps."),
                    Step(order: 2, instruction: "Set a pan over high heat, add ghee. Fry the remaining 30–35 cashews on medium heat, stirring, until light golden. Transfer to a bowl.", tip: "Cashews colour fast — keep stirring and pull them off the heat as soon as they turn golden."),
                    Step(order: 3, instruction: "In the same pan, shallow fry the paneer cubes until golden brown on both sides. Transfer to a bowl. Reserve the remaining ghee in the pan.", timerSeconds: 120),
                    Step(order: 4, instruction: "Drain the soaked cashews. Blend them with the chopped tomato and a little water into a fine, smooth puree. Set aside."),
                    Step(order: 5, instruction: "Heat the reserved ghee in a kadhai on high. Add oil, whole spices (cumin, bay leaf, cardamom, cinnamon), and chopped onions. Cook on medium-high until onions are light golden brown.", timerSeconds: 480),
                    Step(order: 6, instruction: "Add ginger garlic green chilli paste. Cook for 2 minutes until the mixture turns golden brown.", timerSeconds: 120),
                    Step(order: 7, instruction: "Lower the flame. Add all powdered spices (turmeric, Kashmiri chilli, spicy chilli, coriander, cumin) with a splash of hot water. Cook on high for 2–3 minutes until the ghee separates. Add coriander stems and stir.", timerSeconds: 150),
                    Step(order: 8, instruction: "Add the tomato-cashew puree and whisked curd with salt. Stir well and cook on medium-high until the gravy turns crumbly and the ghee separates. Do not add any water at this stage.", tip: "Cooking without water concentrates the flavour — be patient and let the fat separate naturally.", timerSeconds: 600),
                    Step(order: 9, instruction: "Once the gravy is crumbly and the ghee has separated, add hot water to adjust consistency. Cook for 2–3 minutes.", timerSeconds: 150),
                    Step(order: 10, instruction: "Add the fried paneer, fried cashews (reserve a few for garnish), slit green chilli, ginger julienne, garam masala, and kasuri methi powder. Stir and cook for 3–4 minutes.", timerSeconds: 210),
                    Step(order: 11, instruction: "Taste and adjust salt. Finish with fresh coriander. Garnish with reserved fried cashews. Serve with tandoori roti or naan.")
                ],
                imageName: "recipe_paneer_kaju_masala"
            )
        ],
        baseLabel: "Lababdar",
        imageName: "recipe_paneer_lababdar"
    )

    // MARK: - Kaju Masala

    static let kajuMasala = Recipe(
        name: "Kaju Masala",
        cuisine: "North Indian",
        difficulty: .medium,
        totalMinutes: 50,
        defaultServings: 4,
        sfSymbol: "hexagon.fill",
        accentHex: "D97706",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            // Cashew paste
            Ingredient(name: "Onions (for paste)", amount: 3, unit: "medium"),
            Ingredient(name: "Cashew nuts (for paste)", amount: 0.75, unit: "cup"),
            // Gravy
            Ingredient(name: "Ghee", amount: 3, unit: "tbsp"),
            Ingredient(name: "Cashew nuts (to fry)", amount: 0.75, unit: "cup"),
            Ingredient(name: "Oil", amount: 1, unit: "tbsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Cardamom", amount: 3, unit: "nos."),
            Ingredient(name: "Cinnamon", amount: 1, unit: "inch piece"),
            Ingredient(name: "Bay leaf", amount: 1, unit: "no."),
            Ingredient(name: "Garlic (chopped)", amount: 2, unit: "tbsp"),
            Ingredient(name: "Green chillies (chopped)", amount: 2, unit: "nos."),
            Ingredient(name: "Onions (chopped)", amount: 2, unit: "medium"),
            Ingredient(name: "Ginger garlic paste", amount: 1, unit: "tbsp"),
            Ingredient(name: "Turmeric powder", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Kashmiri red chilli powder", amount: 1, unit: "tbsp"),
            Ingredient(name: "Coriander powder", amount: 2, unit: "tsp"),
            Ingredient(name: "Cumin powder", amount: 1, unit: "tsp"),
            Ingredient(name: "Tomatoes (chopped)", amount: 4, unit: "medium"),
            Ingredient(name: "Salt", amount: 1, unit: "to taste"),
            Ingredient(name: "Kasuri methi", amount: 1, unit: "tsp"),
            Ingredient(name: "Garam masala", amount: 1, unit: "tsp"),
            Ingredient(name: "Butter", amount: 1, unit: "tbsp"),
            Ingredient(name: "Cream", amount: 2.5, unit: "tbsp"),
            Ingredient(name: "Fresh coriander (chopped)", amount: 1, unit: "handful")
        ],
        steps: [
            Step(order: 1, instruction: "For the paste: bring a pot of water to boil. Add 3 onions and 3/4 cup cashew nuts. Boil on high flame for 10–12 minutes.", timerSeconds: 720),
            Step(order: 2, instruction: "Strain the boiled cashews and onions, rinse well with fresh water. Transfer to a blender, add a little water, and grind into a fine, smooth paste. Set aside.", tip: "The smoother the paste, the silkier your gravy will be."),
            Step(order: 3, instruction: "Set a wok on low heat. Add ghee and the remaining 3/4 cup cashew nuts. Shallow fry on low flame until golden brown, watching closely as they colour quickly. Remove onto absorbent paper.", tip: "Cashews can burn in seconds — stay attentive and use large-size ones for best results."),
            Step(order: 4, instruction: "In the same wok, add 1 tbsp oil. Add cumin seeds, cardamom, cinnamon, bay leaf, chopped garlic, and green chillies. Stir and cook on low flame until the garlic is nicely cooked.", timerSeconds: 120),
            Step(order: 5, instruction: "Add the chopped onions. Cook on medium flame until golden brown.", timerSeconds: 480),
            Step(order: 6, instruction: "Add ginger garlic paste, turmeric powder, and Kashmiri red chilli powder. Stir and cook on medium-low for 1–2 minutes.", timerSeconds: 90),
            Step(order: 7, instruction: "Add coriander powder and cumin powder. Splash in a little water to prevent burning. Cook on medium-low until the ghee is released.", timerSeconds: 120),
            Step(order: 8, instruction: "Add the chopped tomatoes and salt. Stir well, cover, and cook on low flame for 10–15 minutes, stirring in intervals, until the ghee separates.", tip: "Full ghee release here means the masala is properly cooked — don't rush it.", timerSeconds: 750),
            Step(order: 9, instruction: "Add the prepared onion-cashew paste. Stir and cook on medium flame for 8–10 minutes, stirring continuously, until the gravy comes together.", timerSeconds: 540),
            Step(order: 10, instruction: "Add the fried cashew nuts, kasuri methi, garam masala, butter, and cream. Stir and cook for 2–3 minutes on medium flame. Taste and adjust salt.", timerSeconds: 150),
            Step(order: 11, instruction: "Finish with freshly chopped coriander. Serve hot with naan, roti, or any Indian bread.")
        ],
        imageName: "recipe_paneer"
    )

    // MARK: - Rajma Masala

    static let rajmaMasala = Recipe(
        name: "Dhaba Style Rajma Masala",
        cuisine: "North Indian",
        difficulty: .medium,
        totalMinutes: 45,
        defaultServings: 5,
        sfSymbol: "star.fill",
        accentHex: "991B1B",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            // Rajma
            Ingredient(name: "Chitra rajma (soaked overnight)", amount: 250, unit: "g"),
            Ingredient(name: "Bay leaf", amount: 1, unit: "no."),
            Ingredient(name: "Cinnamon", amount: 2, unit: "inch piece"),
            Ingredient(name: "Black cardamom", amount: 1, unit: "no."),
            Ingredient(name: "Cloves", amount: 3, unit: "nos."),
            // Onion paste
            Ingredient(name: "Onions (for paste)", amount: 3, unit: "medium"),
            // Tomato puree
            Ingredient(name: "Tomatoes", amount: 3, unit: "medium"),
            Ingredient(name: "Garlic", amount: 15, unit: "cloves"),
            Ingredient(name: "Ginger (for puree)", amount: 2, unit: "inch piece"),
            Ingredient(name: "Green chilli", amount: 2, unit: "nos."),
            // Tempering and final cooking
            Ingredient(name: "Ghee", amount: 2, unit: "tbsp"),
            Ingredient(name: "Oil", amount: 1, unit: "tbsp"),
            Ingredient(name: "Cumin seeds", amount: 1, unit: "tsp"),
            Ingredient(name: "Asafoetida (hing)", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Turmeric powder", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Kashmiri red chilli powder", amount: 1, unit: "tbsp"),
            Ingredient(name: "Coriander powder", amount: 2, unit: "tbsp"),
            Ingredient(name: "Cumin powder", amount: 1, unit: "tsp"),
            Ingredient(name: "Dry mango powder (amchur)", amount: 1, unit: "tsp"),
            Ingredient(name: "Black salt", amount: 1, unit: "large pinch"),
            Ingredient(name: "Salt", amount: 1, unit: "to taste"),
            Ingredient(name: "Kasuri methi", amount: 1, unit: "tbsp"),
            Ingredient(name: "Ghee (finishing)", amount: 1.5, unit: "tbsp"),
            Ingredient(name: "Yellow chilli powder", amount: 1, unit: "tsp"),
            Ingredient(name: "Ginger julienne", amount: 1, unit: "handful"),
            Ingredient(name: "Green chilli (sliced)", amount: 2, unit: "nos."),
            Ingredient(name: "Fresh coriander", amount: 1, unit: "handful"),
            Ingredient(name: "Garam masala", amount: 1, unit: "pinch")
        ],
        steps: [
            Step(order: 1, instruction: "Soak rajma in water for 6–8 hours or overnight. Discard the soaking water and wash the rajma thoroughly.", tip: "Washing after soaking removes the compounds that cause bloating and any residual smell."),
            Step(order: 2, instruction: "Transfer rajma to a pressure cooker. Add bay leaf, cinnamon, black cardamom, cloves, a large pinch of salt, and water 1 inch above the rajma. Pressure cook on high for 1 whistle, then on medium for 2–3 more whistles. Let pressure release naturally. Check if cooked; if not, cook 1 more whistle. Discard whole spices.", timerSeconds: 1200),
            Step(order: 3, instruction: "Blend onions into a smooth paste. In a separate jar, blend tomatoes, garlic, ginger, and green chillies into a fine puree. Keep both aside."),
            Step(order: 4, instruction: "Heat ghee and oil in a kadhai on high. Add cumin seeds and asafoetida. Add the onion paste and cook on high, stirring, until golden brown. Splash in hot water if the paste sticks to the pan.", timerSeconds: 480),
            Step(order: 5, instruction: "Lower the flame. Add turmeric, Kashmiri red chilli powder, coriander powder, cumin powder, amchur, and black salt with a splash of water. Cook on high for 1–2 minutes.", timerSeconds: 90),
            Step(order: 6, instruction: "Add the tomato puree and salt. Cook until the ghee separates and the masala turns crumbly — about 10–12 minutes. Add splashes of hot water if it dries out.", tip: "Full ghee release means the masala's raw smell is gone — don't shortcut this step.", timerSeconds: 720),
            Step(order: 7, instruction: "Add the cooked rajma and stir well. Simmer for 6–8 minutes until the gravy is semi-thick. Mash a few rajma against the pot to naturally thicken the gravy faster.", tip: "Mashing 10–15 beans is faster than simmering for another 10 minutes.", timerSeconds: 480),
            Step(order: 8, instruction: "Dry roast kasuri methi in a small pan on medium flame, then crush it between your palms and add to the gravy. In the same pan, heat ghee and pour into the rajma along with yellow chilli powder, ginger julienne, sliced green chilli, garam masala, and fresh coriander. Stir well."),
            Step(order: 9, instruction: "Serve hot with tandoori roti, bread kulcha, or jeera rice.")
        ],
        imageName: "recipe_rajma"
    )

    // MARK: - Chia Pudding

    static let chiaPudding = Recipe(
        name: "Chia Seed Pudding",
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
        ],
        variations: [
            RecipeVariation(
                name: "Mango Coconut",
                accentHex: "F59E0B",
                totalMinutes: 130,
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
                ],
                imageName: "recipe_chia_mango"
            ),
            RecipeVariation(
                name: "Orange Creamsicle",
                accentHex: "F97316",
                totalMinutes: 130,
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
                ],
                imageName: "recipe_chia_orange"
            ),
            RecipeVariation(
                name: "Very Berry",
                accentHex: "7C3AED",
                totalMinutes: 130,
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
                ],
                imageName: "recipe_chia_berry"
            ),
            RecipeVariation(
                name: "Apple Pie",
                accentHex: "DC2626",
                totalMinutes: 135,
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
                ],
                imageName: "recipe_chia_apple"
            ),
            RecipeVariation(
                name: "Pumpkin Spice",
                accentHex: "EA580C",
                totalMinutes: 125,
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
                ],
                imageName: "recipe_chia_pumpkin"
            ),
            RecipeVariation(
                name: "Chocolate Banana",
                accentHex: "78350F",
                totalMinutes: 125,
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
                ],
                imageName: "recipe_chia_chocolate"
            )
        ],
        imageName: "recipe_chia_pudding"
    )

    // MARK: - Pani Puri Pani

    static let paniPuriPani = Recipe(
        name: "Pani Puri Pani",
        cuisine: "Indian Street Food",
        difficulty: .easy,
        totalMinutes: 25,
        defaultServings: 4,
        sfSymbol: "leaf.fill",
        accentHex: "16A34A",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            Ingredient(name: "Fresh mint leaves", amount: 1, unit: "cup"),
            Ingredient(name: "Fresh coriander", amount: 1, unit: "cup"),
            Ingredient(name: "Ginger", amount: 1, unit: "inch piece"),
            Ingredient(name: "Green chilies", amount: 9, unit: "nos."),
            Ingredient(name: "Jaggery", amount: 0.5, unit: "tbsp"),
            Ingredient(name: "Pani puri masala", amount: 1, unit: "to taste"),
            Ingredient(name: "Cold water", amount: 3, unit: "cups"),
            Ingredient(name: "Ice cubes", amount: 1, unit: "handful (optional)")
        ],
        steps: [
            Step(order: 1, instruction: "Add mint, coriander, ginger, green chilies, and jaggery to a blender with a small splash of water. Blend until it begins to break down.", tip: "Use as little water as possible in this first blend — the paste should be thick."),
            Step(order: 2, instruction: "Scrape down the sides and blend again until completely smooth. The paste should be bright green with no visible leaf pieces."),
            Step(order: 3, instruction: "Add a little more water and blend once more to loosen the paste.", timerSeconds: 30),
            Step(order: 4, instruction: "Strain the blended paste through a fine sieve into a large bowl, pressing firmly with a spoon to extract all the liquid. Discard the pulp.", tip: "Straining makes the pani crystal-clear and removes any fibrous bits."),
            Step(order: 5, instruction: "Add cold water to the strained liquid — start with 2 cups and adjust to your preferred strength and spice level."),
            Step(order: 6, instruction: "Add pani puri masala and stir well. Taste and adjust masala, jaggery (sweetness), or green chili heat as needed."),
            Step(order: 7, instruction: "Add ice cubes if serving immediately. Let the pani rest for 10–15 minutes before serving so the flavours come together.", tip: "The pani tastes best ice cold — refrigerate for at least 30 minutes if not serving right away.", timerSeconds: 900)
        ]
    )

    // MARK: - Masala Puri

    static let masalaPuri = Recipe(
        name: "Masala Puri",
        cuisine: "Indian Street Food",
        difficulty: .medium,
        totalMinutes: 40,
        defaultServings: 6,
        sfSymbol: "circle.grid.2x2.fill",
        accentHex: "C2410C",
        isMultiDish: false,
        mealType: .lunchDinner,
        ingredients: [
            // Boiled matar
            Ingredient(name: "Dry green peas", amount: 1, unit: "cup"),
            Ingredient(name: "Salt (for peas)", amount: 1, unit: "to taste"),
            // Paste
            Ingredient(name: "Oil (paste)", amount: 2, unit: "tbsp"),
            Ingredient(name: "Star anise", amount: 1, unit: "no."),
            Ingredient(name: "Cinnamon", amount: 1, unit: "inch piece"),
            Ingredient(name: "Black peppercorns", amount: 0.25, unit: "tsp"),
            Ingredient(name: "Cloves", amount: 4, unit: "nos."),
            Ingredient(name: "Onion (sliced)", amount: 1, unit: "large"),
            Ingredient(name: "Garlic", amount: 9, unit: "cloves"),
            Ingredient(name: "Ginger", amount: 2, unit: "inch piece"),
            Ingredient(name: "Green chilli", amount: 4, unit: "nos."),
            Ingredient(name: "Tomato (chopped)", amount: 2, unit: "nos."),
            Ingredient(name: "Tamarind", amount: 1, unit: "small lemon-sized ball"),
            Ingredient(name: "Fresh coriander", amount: 1, unit: "small handful"),
            Ingredient(name: "Mint leaves", amount: 13, unit: "leaves"),
            // Masala
            Ingredient(name: "Oil (masala)", amount: 2, unit: "tbsp"),
            Ingredient(name: "Turmeric powder", amount: 0.5, unit: "tsp"),
            Ingredient(name: "Kashmiri red chilli powder", amount: 1, unit: "tbsp"),
            Ingredient(name: "Coriander powder", amount: 2, unit: "tsp"),
            Ingredient(name: "Chaat masala", amount: 1, unit: "tsp"),
            Ingredient(name: "Potato (boiled & mashed)", amount: 1, unit: "no."),
            Ingredient(name: "Hot water", amount: 1.25, unit: "litres"),
            // Serving
            Ingredient(name: "Puris", amount: 1, unit: "as needed"),
            Ingredient(name: "Lemon juice", amount: 1, unit: "to taste"),
            Ingredient(name: "Sev", amount: 1, unit: "as needed"),
            Ingredient(name: "Onion (finely chopped)", amount: 1, unit: "small"),
            Ingredient(name: "Carrot (grated)", amount: 1, unit: "small")
        ],
        steps: [
            Step(order: 1, instruction: "Soak dry green peas in plenty of water for at least 6–7 hours or overnight. Drain and discard the soaking water.", tip: "Soaking overnight gives the softest, most evenly cooked peas.", timerSeconds: 25200),
            Step(order: 2, instruction: "Transfer soaked peas to a pressure cooker. Add fresh water (1 inch above the peas) and salt. Pressure cook for 3–4 whistles on medium-high flame.", timerSeconds: 900),
            Step(order: 3, instruction: "Switch off the flame and let the pressure release naturally before opening the lid. Set the boiled peas aside.", timerSeconds: 900),
            Step(order: 4, instruction: "For the paste: heat 2 tbsp oil in a pan on high. Add star anise, cinnamon, peppercorns, and cloves, then add sliced onion, ginger, and garlic. Stir and cook on medium-high until the onions turn translucent.", timerSeconds: 300),
            Step(order: 5, instruction: "Add the chopped tomatoes, a pinch of salt, and a splash of water. Cover and cook on medium flame until the tomatoes are completely mushy.", tip: "Full mushiness is important — undercooked tomatoes make a grainy paste.", timerSeconds: 480),
            Step(order: 6, instruction: "Switch off the flame and let the mixture cool completely. Transfer to a blender along with tamarind, fresh coriander, and mint leaves. Grind into a fine, smooth paste."),
            Step(order: 7, instruction: "For the masala: heat 2 tbsp oil in a deep pan on high. Once hot, add the prepared paste and cook, stirring, for 1–2 minutes.", timerSeconds: 90),
            Step(order: 8, instruction: "Add turmeric, Kashmiri red chilli, coriander powder, and chaat masala. Mix well and cook on medium-low for 2–3 minutes until the oil starts to separate.", tip: "Don't rush this step — toasted spices build the base flavour of the whole dish.", timerSeconds: 150),
            Step(order: 9, instruction: "Add the boiled mashed potato and stir well. Pour in hot water gradually, mixing as you go. Continue cooking for 7–8 minutes until the masala thickens to a gravy consistency.", timerSeconds: 480),
            Step(order: 10, instruction: "To serve: crush a few puris into a plate, top with boiled green peas, then ladle the masala gravy over. Finish with a squeeze of lemon, a pinch of chaat masala, sev, chopped onions, and grated carrot. Add green or tamarind chutney if desired.")
        ]
    )
}
