# frozen_string_literal: true

class Recipes::Validator
  attr_reader :recipe

  def initialize(recipe:)
    @recipe = recipe
  end

  def call
    return { error: recipe.errors.full_messages.join(", ") } unless recipe.valid?

    Ai::Strategy.new(recipe.ai, prompt).call
  end

  def prompt
    Recipes::Prompt.new(recipe: recipe).for_validate
  end
end
