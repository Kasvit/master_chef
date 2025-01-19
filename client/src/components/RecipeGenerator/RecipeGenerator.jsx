import { useState } from "react";
import { AIS } from "../../constants";
import { generate } from "../../services/recipe";
import Recipe from "../Recipe/Recipe";
import RecipeGeneratorForm from "../RecipeGeneratorForm/RecipeGeneratorForm";

function RecipeGenerator() {
  const [ingredients, setIngredients] = useState("");
  const [recipe, setRecipe] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const [ai, setAi] = useState(AIS[0]);
  const [softMode, setSoftMode] = useState(false);

  const generateRecipe = async () => {
    try {
      const response = await generate(ingredients, ai, softMode);
      setRecipe(response.recipe);
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
      <RecipeGeneratorForm 
        onSubmit={handleSubmit} 
        ingredients={ingredients} 
        ai={ai} 
        setIngredients={setIngredients} 
        setAi={setAi} 
        softMode={softMode} 
        setSoftMode={setSoftMode}
      />
      {recipe && 
        <>
          <Recipe recipe={recipe} />
          <button onClick={handleRefresh}>Refresh</button>
        </>
      }
    </>
  );
}

export default RecipeGenerator;
