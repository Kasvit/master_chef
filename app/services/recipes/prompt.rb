class Recipes::Prompt
  attr_reader :ingredients

  FILE = File.read("./app/services/recipes/recipe_template.json")

  def initialize(ingredients)
    @ingredients = ingredients
  end


  # TODO: remove all_ingredients from the prompt and struct to use only the original ingredients
  # TODO: add a checkbox on UI to allow the AI to use additional ingredients Feel free to use any other ingredients that you can find in your kitchen.
  def call
    <<~PROMPT
    You are a world-class chef and you are given a string of ingredients: #{ingredients}. You know how to cook with them.
    You can't use any other ingredients than the ones you are given.
    You must return a recipe in the format of the following format <JSON>.
    Example of the structure:

    ```json
    #{FILE}
    ```

    Recipe structure:
    - name: string
    - ingredients: string with the same ingredients as the ones you are given
    - instructions: array of objects with the following structure:
      - step: string
      - description: string
    - cooking_time: string
    - error: string


    Requirements:
    - Validate the ingredients. If the ingredients are not valid, return an error message in the error field.
    - Return the ingredients string with the ingredients.
    - Return a valid JSON structure.

  PROMPT
  end
end
