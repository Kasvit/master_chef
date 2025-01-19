require 'rails_helper'

RSpec.describe Site, type: :model do
  describe '.current' do
    it 'returns the current site instance' do
      site = Site.current
      expect(site).to be_a(Site)
    end

    it 'memoizes the current site instance' do
      site1 = Site.current
      site2 = Site.current
      expect(site1).to equal(site2)
    end
  end

  describe '#settings' do
    it 'returns the correct settings' do
      site = Site.new
      expect(site.settings).to eq({
        ais: %w[groq claude],
        default_ai: 'groq',
        max_ingredients: 50
      })
    end
  end
end
