# frozen_string_literal: true

class Recipes::Generator
  attr_reader :recipe

  def initialize(recipe:)
    @recipe = recipe
  end

  def call
    return { error: recipe.errors.full_messages.join(", ") } unless recipe.valid?
    # debugger

    Ai::Strategy.new(recipe.ai, prompt).call
  end

  def prompt
    Recipes::Prompt.new(recipe: recipe).for_generate
  end
end
