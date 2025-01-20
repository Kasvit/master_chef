# frozen_string_literal: true

class Recipes::Generator
  attr_reader :recipe

  def initialize(recipe:)
    @recipe = recipe
  end

  def call
    generate
  end

  private

  def generate
    return { error: recipe.errors.full_messages.join(", ") } unless recipe.valid?

    prompt = Recipes::Prompt.new(recipe: recipe).for_generate
    Ai::Strategy.new(recipe.ai, prompt).call
  end
end
