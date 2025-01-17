class Api::V1::RecipesController < ApplicationController
  def generate
    render json: { message: "Hello, Generate!" }
  end
end
