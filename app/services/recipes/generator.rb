# frozen_string_literal: true

class Recipes::Generator
  attr_reader :ingredients, :ai, :soft_mode

  def initialize(ingredients, ai = Site.current.settings[:default_ai], soft_mode = false)
    @ingredients = ingredients
    @ai = ai
    @soft_mode = soft_mode
  end

  def call
    generate
  end

  private

  def generate
    return { error: "invalid ingredients" } unless ingredients_valid?(ingredients)

    prompt = Recipes::Prompt.new(ingredients, soft_mode).call
    case ai
    when "groq"
      Ai::Groq.new(prompt).call
    when "claude"
      Ai::Claude.new(prompt).call
    else # TODO :chatgpt
      { error: "AI not found" }
    end
  end

  def ingredients_valid?(ingredients)
    ingredients.present? && ingredients.length > 3 && ingredients.length <= Site.current.settings[:max_ingredients]
  end
end
