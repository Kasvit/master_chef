import { API_URL } from "../constants";

async function generate(ingredients, ai) {
  const response = await fetch(`${API_URL}/recipes/generate`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ ingredients, ai }),
  });

  if (!response.ok) {
    throw new Error("Failed to generate recipe");
  }

  const data = await response.json();

  return data;
};

export { generate };