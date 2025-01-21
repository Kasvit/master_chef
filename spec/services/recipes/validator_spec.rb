require 'rails_helper'

RSpec.describe Recipes::Validator do
  describe '#call' do
    context 'with valid ingredients' do
      let(:recipe) { build(:recipe) }
      let(:generator) { described_class.new(recipe: recipe) }

      it 'returns a recipe', vcr: { cassette_name: 'ai/groq/validates_recipe' } do
        result = generator.call

        expect(result).to have_key('name')
        expect(result).to have_key('ingredients')
        expect(result).to have_key('instructions')
        expect(result).to have_key('cooking_time')
        expect(result).to have_key('error')
        expect(result['name']).to eq(recipe.name)
      end
    end

    context 'with invalid ingredients' do
      let(:recipe) { build(:recipe, ingredients: '') }
      let(:generator) { described_class.new(recipe: recipe) }

      it 'returns an error message' do
        result = generator.call
        expect(result).to eq({ error: "Ingredients can't be blank, Ingredients is too short (minimum is 3 characters)" })
      end
    end

    context 'with an unknown AI' do
      let(:recipe) { build(:recipe, ai: 'unknown_ai') }
      let(:generator) { described_class.new(recipe: recipe) }

      it 'returns an error message for unknown AI' do
        result = generator.call
        expect(result).to eq({ error: 'Ai is not included in the list' })
      end
    end
  end
end
