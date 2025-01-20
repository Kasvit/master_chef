import { API_URL } from "../constants";

async function generate(ingredients, ai, softMode) {
  const response = await fetch(`${API_URL}/recipes/generate`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ ingredients, ai, soft_mode: softMode }),
  });

  if (!response.ok) {
    throw new Error("Failed to generate recipe");
  }

  const data = await response.json();

  return data;
};

async function validate(recipe, ai, softMode) {
  const response = await fetch(`${API_URL}/recipes/validate`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      recipe: {
        name: recipe.name,
        ingredients: recipe.ingredients,
        cooking_time: recipe.cooking_time,
        error: recipe.error,
        instructions: recipe.instructions,
        ai: ai,
        soft_mode: softMode
      }
    }),
  });

  if (!response.ok) {
    throw new Error("Failed to validate recipe");
  }

  const data = await response.json();

  return data;
};

export { generate, validate };