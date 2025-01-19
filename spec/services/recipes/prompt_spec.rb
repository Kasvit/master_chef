require 'rails_helper'

RSpec.describe Recipes::Prompt do
  describe '#call' do
    context 'with valid ingredients' do
      let(:ingredients) { 'chicken, salt, pepper' }
      let(:prompt) { described_class.new(ingredients, false) }

      it 'generates a valid prompt' do
        expected_prompt = <<~PROMPT
          You are a world-class chef and you are given a string of ingredients: #{ingredients}. You know how to cook with them.
          You can't use any other ingredients than the ones you are given.
          You must return a recipe in the format of the following format <JSON>.
          Example of the structure:

          ```json
          #{Recipes::Prompt::FILE}
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
          - Return the ingredients string with the ALL used ingredients.
          - Return ONLY a valid JSON structure without explanation, code, or other blocks and descriptions.

        PROMPT

        expect(prompt.call.strip).to eq(expected_prompt.strip)
      end
    end

    context 'with no ingredients' do
      let(:ingredients) { '' }
      let(:prompt) { described_class.new(ingredients, false) }

      it 'generates a prompt indicating no ingredients' do
        expected_prompt = <<~PROMPT
          You are a world-class chef and you are given a string of ingredients: #{ingredients}. You know how to cook with them.
          You can't use any other ingredients than the ones you are given.
          You must return a recipe in the format of the following format <JSON>.
          Example of the structure:

          ```json
          #{Recipes::Prompt::FILE}
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
          - Return the ingredients string with the ALL used ingredients.
          - Return ONLY a valid JSON structure without explanation, code, or other blocks and descriptions.

        PROMPT

        expect(prompt.call.strip).to eq(expected_prompt.strip)
      end
    end

    context 'with soft mode' do
      let(:ingredients) { 'chicken, salt, pepper' }
      let(:prompt) { described_class.new(ingredients, true) }

      it 'generates a valid prompt' do
        expected_prompt = <<~PROMPT
          You are a world-class chef and you are given a string of ingredients: #{ingredients}. You know how to cook with them.
          Feel free to use any other ingredients that you can find in your kitchen.
          You must return a recipe in the format of the following format <JSON>.
          Example of the structure:

          ```json
          #{Recipes::Prompt::FILE}
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
          - Return the ingredients string with the ALL used ingredients.
          - Return ONLY a valid JSON structure without explanation, code, or other blocks and descriptions.

        PROMPT

        expect(prompt.call.strip).to eq(expected_prompt.strip)
      end
    end
  end
end
