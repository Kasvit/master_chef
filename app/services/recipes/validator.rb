# frozen_string_literal: true

class Recipes::Validator
  attr_reader :recipe

  def initialize(recipe:)
    @recipe = recipe
  end

  def call
    validate
  end

  private

  def validate
    return { error: recipe.errors.full_messages.join(", ") } unless recipe.valid?

    prompt = Recipes::Prompt.new(recipe: recipe).for_validate
    Ai::Strategy.new(recipe.ai, prompt).call
  end
end
