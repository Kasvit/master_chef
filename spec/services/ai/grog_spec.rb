require 'rails_helper'

RSpec.describe Ai::Groq do
  describe '#call' do
    let(:recipe) { build(:recipe, ingredients: 'chicken, salt, pepper', soft_mode: false) }
    let(:prompt) { Recipes::Prompt.new(recipe: recipe).for_generate }
    let(:groq) { described_class.new(prompt) }

    context 'when given a valid prompt' do
      it 'returns a valid recipe structure' do
        VCR.use_cassette('ai/groq/generates_recipe') do
          result = groq.call
          expect(result['name']).to eq('Grilled Chicken')
          expect(result['ingredients']).to eq('chicken, salt, pepper')
          expect(result['cooking_time']).to eq('20 minutes')
          expect(result['error']).to eq('')
        end
      end
    end

    context 'when the prompt is invalid' do
      let(:ingredients) { '' }

      it 'returns an error message' do
        VCR.use_cassette('ai/groq/failed_generates_recipe') do
          result = groq.call
          expect(result['error']).to eq('No ingredients provided')
        end
      end
    end
  end
end
