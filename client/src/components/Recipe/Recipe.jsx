import React from "react";
import PropTypes from "prop-types";

function Recipe({ recipe }) {
  if (!recipe) {
    return null;
  }

  if (recipe.error) {
    return <p>{recipe.error}</p>;
  }

  return (
    <div>
      <h3>{recipe.name}</h3>
      <p><strong>Cooking Time:</strong> {recipe.cooking_time}</p>
      <p><strong>Ingredients:</strong></p>
      <ul>
        {recipe.ingredients.split(', ').map((ingredient, index) => (
          <li key={index}>{ingredient}</li>
        ))}
      </ul>
      {recipe.instructions.length > 0 && (
        <>
          <p><strong>Instructions:</strong></p>
          <ol>
            {recipe.instructions.map((instruction, index) => (
              <li key={index}>
                <strong>Step {index + 1}:</strong> {instruction.step}
                <p>{instruction.description}</p>
              </li>
            ))}
          </ol>
        </>
      )}
      {recipe.error && <p style={{ color: "red" }}><strong>Error:</strong> {recipe.error}</p>}
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
