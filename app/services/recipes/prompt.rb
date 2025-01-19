class Recipes::Prompt
  attr_reader :ingredients, :soft_mode

  FILE = File.read("./app/services/recipes/recipe_template.json")

  def initialize(ingredients, soft_mode)
    @ingredients = ingredients
    @soft_mode = soft_mode
  end

  def call
    <<~PROMPT
    You are a world-class chef and you are given a string of ingredients: "#{ingredients}". You know how to cook with them.
    #{if soft_mode
      "Feel free to use any other ingredients that you can find in your kitchen."
      else
      "You can't use any other ingredients than the ones you are given."
      end}
    You must return a recipe in the format of the following format <JSON>.
    Example of the structure:

    ```json
    #{FILE}
    ```

    Recipe structure:
    - name: string
    - ingredients: string with the same ingredients as the ones you are given
    - instructions: array of objects with the following structure:
      - step: string without numeration
      - description: string
    - cooking_time: string
    - error: string


    Requirements:
    - Validate the ingredients. If the ingredients are not valid, return an error message in the error field.
    - In case of any error, return an the same json structure but with the error field filled.
    - Return the ingredients string with the ALL used ingredients.
    - Return ONLY a valid JSON structure without explanation, code, or other blocks and descriptions.

  PROMPT
  end
end
