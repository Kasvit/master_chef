require 'rails_helper'

RSpec.describe "Api::V1::Recipes", type: :request do
  describe 'POST /api/v1/recipes/generate' do
    context 'with valid ingredients and AI' do
      let(:valid_params) do
        {
          recipe: {
            ingredients: 'chicken, salt, pepper',
            ai: 'groq'
          }
        }
      end

      it 'returns a recipe' do
        allow_any_instance_of(Ai::Groq).to receive(:call).and_return({ name: 'Chicken Dish', ingredients: valid_params[:recipe][:ingredients], instructions: [], cooking_time: '30 minutes', error: nil })

        post '/api/v1/recipes/generate', params: valid_params

        expect(response).to have_http_status(:success)
        expect(parsed_response).to have_key('recipe')
      end
    end

    context 'with invalid ingredients' do
      let(:invalid_params) do
        {
          recipe: {
            ingredients: 'sa',
            ai: 'groq'
          }
        }
      end

      it 'returns an error for invalid ingredients' do
        post '/api/v1/recipes/generate', params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['recipe']['error']).to eq("Ingredients is too short (minimum is 3 characters)")
      end
    end

    context 'with invalid AI' do
      let(:invalid_ai_params) do
        {
          recipe: {
            ingredients: 'chicken, salt, pepper',
            ai: 'invalid_ai'
          }
        }
      end

      it 'returns an error for invalid AI' do
        post '/api/v1/recipes/generate', params: invalid_ai_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['recipe']['error']).to eq('Ai is not included in the list')
      end
    end
  end
end
