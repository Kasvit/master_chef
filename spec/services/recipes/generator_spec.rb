require 'rails_helper'

RSpec.describe Recipes::Generator do
  describe '#call' do
    context 'with valid ingredients' do
      let(:recipe) { build(:recipe, ingredients: 'chicken, salt, pepper', ai: 'groq') }
      let(:generator) { described_class.new(recipe: recipe) }

      VCR.use_cassette('ai/groq/generates_recipe', record: :new_episodes) do
        it 'returns a recipe' do
          allow_any_instance_of(Ai::Groq).to receive(:call).and_return({ name: 'Chicken Dish', ingredients: recipe.ingredients, instructions: [], cooking_time: '30 minutes', error: nil })

          result = generator.call
          expect(result).to have_key(:name)
          expect(result).to have_key(:ingredients)
          expect(result).to have_key(:instructions)
          expect(result).to have_key(:cooking_time)
          expect(result).to have_key(:error)
          expect(result[:name]).to eq('Chicken Dish')
        end
      end
    end

    context 'with invalid ingredients' do
      let(:recipe) { build(:recipe, ingredients: '', ai: 'groq') }
      let(:generator) { described_class.new(recipe: recipe) }

      VCR.use_cassette('ai/groq/failed_generates_recipe') do
        it 'returns an error message' do
          result = generator.call
          expect(result).to eq({ error: "Ingredients can't be blank, Ingredients is too short (minimum is 3 characters)" })
        end
      end
    end

    context 'with an unknown AI' do
      let(:recipe) { build(:recipe, ingredients: 'chicken, salt, pepper', ai: 'unknown_ai') }
      let(:generator) { described_class.new(recipe: recipe) }

      it 'returns an error message for unknown AI' do
        result = generator.call
        expect(result).to eq({ error: 'Ai is not included in the list' })
      end
    end
  end
end
