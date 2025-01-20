# frozen_string_literal: true

class Recipe
  include ActiveModel::Model

  attr_accessor :name, :description, :ingredients, :instructions, :ai, :soft_mode, :cooking_time, :error

  validates :ingredients, presence: true, length: { minimum: 3, maximum: 50 }
  validates :ai, presence: true
  validates :ai, inclusion: { in: Site.current.settings[:ais] }
end
