# frozen_string_literal: true

class Site
  def self.current
    @current ||= Site.new
  end

  def settings
    {
      ais: %w[grog claude],
      default_ai: "grog"
    }
  end
end
