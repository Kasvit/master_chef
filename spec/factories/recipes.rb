FactoryBot.define do
  factory :recipe do
    name { "Grilled Chicken" }
    description { "A delicious Grilled Chicken." }
    ingredients { "chicken, salt, pepper" }
    instructions do
      [
        { step: "Prepare the Chicken", description: "Rinse the chicken under cold water, pat it dry with paper towels" },
        { step: "Season the Chicken", description: "Sprinkle salt and pepper evenly over both sides of the chicken" },
        { step: "Grill the Chicken", description: "Place the chicken on a preheated grill and cook for about 5-6 minutes per side, or until it reaches an internal temperature of 165°F" },
        { step: "Rest the Chicken", description: "Once cooked, remove the chicken from the grill and let it rest for a few minutes before serving" }
      ]
    end
    ai { "groq" }
    soft_mode { false }
    cooking_time { "20 minutes" }
    error { "" }
  end
end
