class Api::V1::RecipesController < ApplicationController
  include RailsRateLimit::Controller

  set_rate_limit limit: 3, period: 5.seconds, only: [ :generate ]

  def generate
    @recipe = Recipe.new(generate_params)
    if @recipe.valid?
      recipe = Recipes::Generator.new(@recipe).call
      render json: { recipe: recipe }
    else
      render json: { recipe: { error: @recipe.errors.full_messages.join(", ") } }, status: :unprocessable_entity
    end
  end

  private

  def generate_params
    params.require(:recipe).permit(:ingredients, :ai, :soft_mode)
  end
end
