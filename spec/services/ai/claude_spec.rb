require 'rails_helper'

RSpec.describe Ai::Claude do
  describe '#call' do
    let(:recipe) { build(:recipe) }
    let(:prompt) { Recipes::Prompt.new(recipe: recipe).for_generate }
    let(:claude) { described_class.new(prompt) }

    context 'when given a valid prompt' do
      it 'returns a valid recipe structure' do
        VCR.use_cassette('ai/claude/generates_recipe') do
          result = claude.call
          expect(result['name']).to eq('Chicken with Salt and Pepper')
          expect(result['ingredients']).to eq('chicken, salt, pepper')
          expect(result['cooking_time']).to eq('30 minutes')
          expect(result['error']).to eq('')
        end
      end
    end

    context 'when the prompt is invalid' do
      it 'returns an error message' do
        VCR.use_cassette('ai/claude/failed_generates_recipe') do
          result = claude.call
          expect(result['error']).to eq('No ingredients provided')
        end
      end
    end
  end
end
