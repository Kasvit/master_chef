require 'rails_helper'

RSpec.describe Recipes::Generator do
  describe '#call' do
    context 'with valid ingredients' do
      let(:ingredients) { 'chicken, salt, pepper' }
      let(:ai) { 'groq' }
      let(:generator) { described_class.new(ingredients, ai) }

      it 'returns a recipe' do
        allow(Ai::Groq).to receive(:new).and_return(double(call: { name: 'Chicken Dish', ingredients: ingredients, instructions: [], cooking_time: '30 minutes', error: nil }))
        
        result = generator.call
        expect(result).to have_key(:name)
        expect(result).to have_key(:ingredients)
        expect(result).to have_key(:instructions)
        expect(result).to have_key(:cooking_time)
        expect(result).to have_key(:error)
        expect(result[:name]).to eq('Chicken Dish')
      end
    end

    context 'with invalid ingredients' do
      let(:ingredients) { 'sal' }
      let(:ai) { 'groq' }
      let(:generator) { described_class.new(ingredients, ai) }

      it 'returns an error message' do
        result = generator.call
        expect(result).to eq({ error: 'invalid ingredients' })
      end
    end

    context 'with an unknown AI' do
      let(:ingredients) { 'chicken, salt, pepper' }
      let(:ai) { 'unknown_ai' }
      let(:generator) { described_class.new(ingredients, ai) }

      it 'returns an error message for unknown AI' do
        result = generator.call
        expect(result).to eq({ error: 'AI not found' })
      end
    end
  end
end 