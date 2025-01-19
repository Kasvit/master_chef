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
    return (
      <div className="flex justify-center items-center py-12">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="text-center py-8">
        <p className="text-red-600 mb-4">{error}</p>
        <button 
          onClick={handleRefresh}
          className="bg-blue-600 text-white py-2 px-4 rounded-lg hover:bg-blue-700 transition-colors duration-200"
        >
          Try again
        </button>
      </div>
    );
  }

  return (
    <div className="space-y-8">
      <RecipeGeneratorForm 
        onSubmit={handleSubmit} 
        ingredients={ingredients} 
        ai={ai} 
        setIngredients={setIngredients} 
        setAi={setAi} 
        softMode={softMode} 
        setSoftMode={setSoftMode}
      />
      {recipe && (
        <div className="space-y-6">
          <Recipe recipe={recipe} />
          <div className="text-center">
            <button 
              onClick={handleRefresh}
              className="bg-gray-200 text-gray-800 py-2 px-6 rounded-lg hover:bg-gray-300 transition-colors duration-200"
            >
              Start Over
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

export default RecipeGenerator;
