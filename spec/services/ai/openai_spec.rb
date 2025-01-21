require 'rails_helper'

RSpec.describe Ai::Openai do
  describe '#call' do
    let(:recipe) { build(:recipe) }
    let(:prompt) { Recipes::Prompt.new(recipe: recipe).for_generate }
    let(:openai) { described_class.new(prompt) }

    context 'when given a valid prompt' do
      it 'returns a valid recipe structure' do
        VCR.use_cassette('ai/openai/generates_recipe') do
          result = openai.call
          expect(result['name']).to eq('Seasoned Chicken')
          expect(result['ingredients']).to eq('chicken, salt, pepper')
          expect(result['cooking_time']).to eq('20 minutes')
          expect(result['error']).to eq('')
        end
      end
    end

    context 'when the prompt is invalid' do
      it 'returns an error message' do
        VCR.use_cassette('ai/openai/failed_generates_recipe') do
          result = openai.call
          expect(result['error']).to eq('Invalid ingredients provided')
        end
      end
    end
  end
end
