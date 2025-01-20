require 'rails_helper'

RSpec.describe Recipes::Prompt do
  describe '#call' do
    context 'with valid ingredients' do
      let(:recipe) { build(:recipe, ingredients: 'chicken, salt, pepper', soft_mode: false) }
      let(:prompt) { described_class.new(recipe: recipe) }

      it 'generates a valid prompt' do
        expected_prompt = <<~PROMPT
          You are a world-class chef tasked with creating a recipe using a given set of ingredients. Your goal is to create a delicious dish and present the recipe in a specific JSON format.

          You will be given a string of ingredients:
          <ingredients>
          "#{recipe.ingredients}"
          </ingredients>

          You can't use any other ingredients than the ones you are given.

          The recipe should be returned in the following JSON format:
          ```json
          {
            "name": "dish name",
            "ingredients": "comma-separated list of ingredients",
            "instructions": [
              {
                "step": "step name",
                "description": "step description"
              }
            ],
            "cooking_time": "cooking time in minutes",
            "error": ""
          }
          ```

          Requirements:
          1. Validate the ingredients. If the ingredients are not valid or recognizable, return an error message in the "error" field.
          2. Include ALL used ingredients in the "ingredients" field.
          You can't use any other ingredients than the ones you are given.
          3. Provide clear and concise instructions in the "instructions" array.
          4. Estimate a reasonable cooking time for the dish.
          5. Return ONLY a valid JSON structure without any additional explanation, code blocks, or descriptions.

          Example of the response:
          ```json
          #{Recipes::Prompt::FILE}
          ```

          To complete this task:

          1. First, examine the given ingredients carefully. If they are not recognizable as food items or are nonsensical, set the "error" field to "Invalid ingredients provided" and leave the other fields empty.

          2. If the ingredients are valid, create a recipe that incorporates them along with other common ingredients. Be creative but realistic in your dish creation.

          3. Choose an appropriate name for your dish and set it as the "name" value.

          4. List ALL ingredients used in the "ingredients" field, separated by commas.

          5. Create a series of clear, step-by-step instructions for preparing the dish. Each step should be an object in the "instructions" array with a "step" (brief title) and "description" (more detailed explanation).

          6. Estimate how long it would take to prepare and cook the dish, and set this as the "cooking_time" value. Include the unit of time (e.g., "30 minutes" or "2 hours").

          7. Ensure that your output is a valid JSON structure and contains only the specified fields.

          Remember to return ONLY the JSON structure without any additional text or explanations.
        PROMPT

        expect(prompt.for_generate.strip).to eq(expected_prompt.strip)
      end
    end

    context 'with soft mode' do
      let(:recipe) { build(:recipe, ingredients: 'chicken, salt, pepper', soft_mode: true) }
      let(:prompt) { described_class.new(recipe: recipe) }

      it 'generates a valid prompt' do
        expected_prompt = <<~PROMPT
          You are a world-class chef tasked with creating a recipe using a given set of ingredients. Your goal is to create a delicious dish and present the recipe in a specific JSON format.

          You will be given a string of ingredients:
          <ingredients>
          "#{recipe.ingredients}"
          </ingredients>

          Feel free to use any other ingredients that you can find in your kitchen.

          The recipe should be returned in the following JSON format:
          ```json
          {
            "name": "dish name",
            "ingredients": "comma-separated list of ingredients",
            "instructions": [
              {
                "step": "step name",
                "description": "step description"
              }
            ],
            "cooking_time": "cooking time in minutes",
            "error": ""
          }
          ```

          Requirements:
          1. Validate the ingredients. If the ingredients are not valid or recognizable, return an error message in the "error" field.
          2. Include ALL used ingredients in the "ingredients" field.
          If you use additional ingredients, include them in the 'ingredients' field.
          3. Provide clear and concise instructions in the "instructions" array.
          4. Estimate a reasonable cooking time for the dish.
          5. Return ONLY a valid JSON structure without any additional explanation, code blocks, or descriptions.

          Example of the response:
          ```json
          #{Recipes::Prompt::FILE}
          ```

          To complete this task:

          1. First, examine the given ingredients carefully. If they are not recognizable as food items or are nonsensical, set the "error" field to "Invalid ingredients provided" and leave the other fields empty.

          2. If the ingredients are valid, create a recipe that incorporates them along with other common ingredients. Be creative but realistic in your dish creation.

          3. Choose an appropriate name for your dish and set it as the "name" value.

          4. List ALL ingredients used in the "ingredients" field, separated by commas.

          5. Create a series of clear, step-by-step instructions for preparing the dish. Each step should be an object in the "instructions" array with a "step" (brief title) and "description" (more detailed explanation).

          6. Estimate how long it would take to prepare and cook the dish, and set this as the "cooking_time" value. Include the unit of time (e.g., "30 minutes" or "2 hours").

          7. Ensure that your output is a valid JSON structure and contains only the specified fields.

          Remember to return ONLY the JSON structure without any additional text or explanations.
        PROMPT

        expect(prompt.for_generate.strip).to eq(expected_prompt.strip)
      end
    end
  end
end
