class Api::V1::RecipesController < ApplicationController
  include RailsRateLimit::Controller

  set_rate_limit limit: 3, period: 5.seconds, only: [ :generate ]

  def generate
    return render json: { recipe: { error: "invalid ingredients" } }, status: :unprocessable_entity unless validate_ingredients
    return render json: { recipe: { error: "invalid AI" } }, status: :unprocessable_entity unless validate_ai

    recipe = Recipes::Generator.new(params[:ingredients], params[:ai]).call

    render json: { recipe: recipe }
  end

  private

  def validate_ingredients
    ingredients = generate_params[:ingredients]
    ingredients.present? && ingredients.length > 3 && ingredients.length <= Site.current.settings[:max_ingredients]
  end

  def validate_ai
    generate_params[:ai].present? && Site.current.settings[:ais].include?(generate_params[:ai])
  end

  def generate_params
    params.require(:recipe).permit(:ingredients, :ai)
  end
end
