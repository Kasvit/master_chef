import PropTypes from 'prop-types';
import { AIS } from "../../constants";

function RecipeGeneratorForm({ onSubmit, ingredients, ai, setIngredients, setAi, softMode, setSoftMode }) {
  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold text-gray-800">Please enter your ingredients</h2>
      <div className="space-y-4">
        <div className="flex flex-col">
          <input
            type="text"
            placeholder="Enter ingredients"
            value={ingredients}
            onChange={(e) => setIngredients(e.target.value)}
            className="p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          />
        </div>
        
        <div className="flex items-center space-x-4">
          <div className="flex items-center space-x-2">
            <label htmlFor="ai" className="font-medium text-gray-700">AI Model:</label>
            <select 
              value={ai} 
              onChange={(e) => setAi(e.target.value)}
              className="p-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
              {AIS.map((ai, index) => (
                <option key={index} value={ai}>{ai.toUpperCase()}</option>
              ))}
            </select>
          </div>

          <div className="flex items-center space-x-2">
            <label htmlFor="softMode" className="font-medium text-gray-700">
              Use additional ingredients
            </label>
            <input 
              type="checkbox" 
              checked={softMode} 
              onChange={(e) => setSoftMode(e.target.checked)}
              className="w-4 h-4 text-blue-600 rounded focus:ring-blue-500"
            />
          </div>
        </div>

        <button 
          onClick={onSubmit}
          className="w-full bg-blue-600 text-white py-3 px-6 rounded-lg hover:bg-blue-700 transition-colors duration-200"
        >
          Let's cook!
        </button>
      </div>
    </div>
  );
}

RecipeGeneratorForm.propTypes = {
  onSubmit: PropTypes.func.isRequired,
  ingredients: PropTypes.string.isRequired,
  ai: PropTypes.string.isRequired,
  setIngredients: PropTypes.func.isRequired,
  setAi: PropTypes.func.isRequired,
  softMode: PropTypes.bool.isRequired,
  setSoftMode: PropTypes.func.isRequired,
};

export default RecipeGeneratorForm;
