class Api::V1::RecipesController < ApplicationController
  include RailsRateLimit::Controller

  set_rate_limit limit: 5, period: 5.seconds

  def generate
    @recipe = Recipe.new(generate_params)
    if @recipe.valid?
      recipe = Recipes::Generator.new(recipe: @recipe).call
      render json: { recipe: recipe }
    else
      render json: { recipe: { error: @recipe.errors.full_messages.join(", ") } }, status: :unprocessable_entity
    end
  end

  def validate
    @recipe = Recipe.new(validate_params)
    if @recipe.valid? && Recipes::Validator.new(recipe: @recipe).call
      render json: { recipe: @recipe }
    else
      render json: { recipe: { error: @recipe.errors.full_messages.join(", ") } }, status: :unprocessable_entity
    end
  end

  private

  def generate_params
    params.require(:recipe).permit(:ingredients, :ai, :soft_mode)
  end

  def validate_params
    params.require(:recipe).permit(:name, :ingredients, :cooking_time, :error, :ai, :soft_mode, instructions: [ :step, :description ])
  end
end
