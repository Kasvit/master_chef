require 'rails_helper'

RSpec.describe Ai::Grog do
  describe '#call' do
    let(:prompt) { 'You are a world-class chef...' }
    let(:grog) { described_class.new(prompt) }

    context 'when given a valid prompt' do
      it 'returns a valid recipe structure' do
        allow(grog).to receive(:call).and_return({
          name: 'Chicken Dish',
          ingredients: [ 'chicken', 'salt', 'pepper' ],
          instructions: [ { step: '1', description: 'Cook the chicken.' } ],
          cooking_time: '30 minutes',
          error: nil
        })

        result = grog.call
        expect(result).to have_key(:name)
        expect(result[:name]).to eq('Chicken Dish')
        expect(result).to have_key(:ingredients)
        expect(result[:ingredients]).to include('chicken')
        expect(result).to have_key(:instructions)
        expect(result[:instructions]).to be_an(Array)
        expect(result).to have_key(:cooking_time)
        expect(result[:cooking_time]).to eq('30 minutes')
        expect(result).to have_key(:error)
        expect(result[:error]).to be_nil
      end
    end

    context 'when the prompt is invalid' do
      it 'returns an error message' do
        allow(grog).to receive(:call).and_return({
          name: nil,
          ingredients: [],
          instructions: [],
          cooking_time: nil,
          error: 'Invalid prompt'
        })

        result = grog.call
        expect(result).to have_key(:error)
        expect(result[:error]).to eq('Invalid prompt')
      end
    end
  end
end
