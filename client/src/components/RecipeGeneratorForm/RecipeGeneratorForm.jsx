import PropTypes from 'prop-types';
import { AIS } from "../../constants";
import styles from "./RecipeGeneratorForm.module.scss";

function RecipeGeneratorForm({ onSubmit, ingredients, ai, setIngredients, setAi }) {

  return (
    <>
      <h2 className={styles.title}> Please enter your ingredients</h2>
      <input
        type="text"
        placeholder="Enter ingredients"
        value={ingredients}
        onChange={(e) => setIngredients(e.target.value)}
      />
      <select value={ai} onChange={(e) => setAi(e.target.value)}>
        {AIS.map((ai, index) => (
          <option key={index} value={ai}>{ai}</option>
        ))}
      </select>
      <button onClick={onSubmit}>Let's cook!</button>
    </>
  );
}

RecipeGeneratorForm.propTypes = {
  onSubmit: PropTypes.func.isRequired,
  ingredients: PropTypes.string.isRequired,
  ai: PropTypes.string.isRequired,
  setIngredients: PropTypes.func.isRequired,
  setAi: PropTypes.func.isRequired,
};

export default RecipeGeneratorForm;
