# frozen_string_literal: true

class Recipes::Generator
  attr_reader :ingredients, :ai
  
  def initialize(ingredients, ai = Site.current.settings[:default_ai])
    @ingredients = ingredients
    @ai = ai
  end

  def call
    generate
  end

  private

  def generate
    return { error: "invalid ingredients" } unless ingredients_valid?(ingredients)
    prompt = Recipes::Prompt.new(ingredients).call
    puts '--------------------------------'
    p prompt
    puts '--------------------------------'
    case ai
    when "groq"
      Ai::Groq.new(prompt).call
    else
      { error: "AI not found" }
    end
  end

  def ingredients_valid?(ingredients)
    ingredients.present? && ingredients.length > 3 && ingredients.length <= Site.current.settings[:max_ingredients]
  end
end