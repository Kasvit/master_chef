import { useState } from "react";
import { API_URL } from "../../../constants";
import styles from "./Recipe.module.scss";

function Recipe() {
  const [ingredients, setIngredients] = useState("");
  const [recipe, setRecipe] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  const generateRecipe = async () => {
    try {
      const response = await fetch(`${API_URL}/recipes/generate`, {
        method: "POST",
        body: JSON.stringify({ ingredients }),
      });

      if (!response.ok) {
        throw new Error("Failed to generate recipe");
      }

      const data = await response.json();
      setRecipe(data.recipe);

    } catch (error) {
      setError(error.message);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setLoading(true);
    generateRecipe();
  };

  const handleRefresh = () => {
    setError(null);
    setRecipe(null);
    setLoading(false);
  };

  if (loading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return (
      <>
        <p>{error}</p>
        <button onClick={handleRefresh}>Try again</button>
      </>
    )
  }

  return (
    <>
      <h2 className={styles.title}> Please enter your ingredients</h2>
      <input
        type="text"
        placeholder="Enter ingredients"
        value={ingredients}
        onChange={(e) => setIngredients(e.target.value)}
      />
      <button onClick={handleSubmit}>Let's cook!</button>
      {recipe && <p>{recipe}</p>}
    </>
  );
}

export default Recipe;
