# frozen_string_literal: true

class Ai::Grog < Ai::Base
  def call
    puts "Generating recipe with GROG"

    {
      name: "salad",
      ingredients: 'lettuce, tomato, cucumber',
      instructions: [],
      cooking_time: "10 minutes",
      error: ""
    }
  end
end
