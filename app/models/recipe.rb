# frozen_string_literal: true

class Recipe
  include ActiveModel::Model

  attr_accessor :name, :description, :ingredients, :instructions, :ai, :soft_mode, :cooking_time, :error

  validates :ingredients, presence: true, length: { minimum: 3, maximum: 50 }
  validates :ai, presence: true
  validate :ai_must_be_in_list

  private

  def ai_must_be_in_list
    errors.add(:ai, 'is not included in the list') unless Site.current.settings[:ais].include?(ai)
  end
end

