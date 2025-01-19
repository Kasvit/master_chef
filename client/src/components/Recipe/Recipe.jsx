import React from "react";
import PropTypes from "prop-types";

function Recipe({ recipe }) {
  if (!recipe) {
    return null;
  }

  if (recipe.error) {
    return <p className="text-red-600 font-medium">{recipe.error}</p>;
  }

  return (
    <div className="mt-8 space-y-6">
      <h3 className="text-2xl font-bold text-gray-800 border-b pb-2">{recipe.name}</h3>
      
      <div className="bg-blue-50 p-4 rounded-lg">
        <p className="text-lg text-gray-800"><strong>Cooking Time:</strong> {recipe.cooking_time}</p>
      </div>

      <div className="space-y-4">
        <h4 className="text-xl font-semibold text-gray-700 text-center">Ingredients:</h4>
        <div className="flex flex-wrap justify-center gap-2">
          {recipe.ingredients.split(', ').map((ingredient, index) => (
            <span 
              key={index} 
              className="bg-blue-100 text-blue-800 px-4 py-2 rounded-full text-sm font-medium"
            >
              {ingredient}
            </span>
          ))}
        </div>
      </div>

      {recipe.instructions.length > 0 && (
        <div className="space-y-4">
          <h4 className="text-xl font-semibold text-gray-700">Instructions:</h4>
          <ol className="space-y-4">
            {recipe.instructions.map((instruction, index) => (
              <li key={index} className="bg-gray-50 p-4 rounded-lg">
                <p className="font-semibold text-gray-800">Step {index + 1}: {instruction.step}</p>
                <p className="mt-2 text-gray-600">{instruction.description}</p>
              </li>
            ))}
          </ol>
        </div>
      )}
      
      {recipe.error && (
        <p className="text-red-600 font-medium mt-4">
          <strong>Error:</strong> {recipe.error}
        </p>
      )}
    </div>
  );
}

Recipe.propTypes = {
  recipe: PropTypes.shape({
    name: PropTypes.string.isRequired,
    cooking_time: PropTypes.string.isRequired,
    ingredients: PropTypes.string.isRequired,
    instructions: PropTypes.arrayOf(PropTypes.shape({
      step: PropTypes.string.isRequired,
      description: PropTypes.string.isRequired,
    })).isRequired,
    error: PropTypes.string,
  })
};

export default Recipe;
