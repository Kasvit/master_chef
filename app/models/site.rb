# frozen_string_literal: true

class Site
  def self.current
    @current ||= Site.new
  end

  def settings
    {
      ais: %w[groq claude openai],
      default_ai: "groq",
      max_ingredients: 50
    }
  end
end
