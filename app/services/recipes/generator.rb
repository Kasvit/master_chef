# frozen_string_literal: true

class Recipes::Generator
  GROQ = "groq".freeze
  CLAUDE = "claude".freeze
  OPENAI = "openai".freeze
  attr_reader :recipe

  def initialize(recipe)
    @recipe = recipe
  end

  def call
    generate
  end

  private

  def generate
    return { error: recipe.errors.full_messages.join(", ") } unless recipe.valid?

    prompt = Recipes::Prompt.new(ingredients: recipe.ingredients, soft_mode: recipe.soft_mode).for_generate
    case recipe.ai
    when GROQ
      Ai::Groq.new(prompt).call
    when CLAUDE
      Ai::Claude.new(prompt).call
    when OPENAI
      Ai::Openai.new(prompt).call
    else # TODO :chatgpt
      { error: "AI not found" }
    end
  end
end
