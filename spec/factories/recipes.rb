FactoryBot.define do
  factory :recipe do
    name { "Sample Recipe" }
    description { "A delicious sample recipe." }
    ingredients { "chicken, salt, pepper" }
    instructions { [ { step: "Prepare the ingredients", description: "Prepare the ingredients" } ] }
    ai { "groq" }
    soft_mode { false }
    cooking_time { "30 minutes" }
    error { "" }
  end
end
