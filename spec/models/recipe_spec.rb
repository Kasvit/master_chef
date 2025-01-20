require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject { build(:recipe) }

  describe 'validations' do
    it { should validate_presence_of(:ingredients) }
    it { should validate_length_of(:ingredients).is_at_least(3).is_at_most(50) }
    it { should validate_presence_of(:ai) }
    it { should validate_inclusion_of(:ai).in_array(Site.current.settings[:ais]) }
  end

  describe 'attributes' do
    it 'has a name' do
      expect(subject.name).to eq("Sample Recipe")
    end

    it 'has a description' do
      expect(subject.description).to eq("A delicious sample recipe.")
    end

    it 'has ingredients' do
      expect(subject.ingredients).to eq("chicken, salt, pepper")
    end

    it 'has instructions' do
      expect(subject.instructions).to eq([ { step: "Prepare the ingredients", description: "Prepare the ingredients" } ])
    end

    it 'has cooking time' do
      expect(subject.cooking_time).to eq("30 minutes")
    end

    it 'has an error message' do
      expect(subject.error).to eq("")
    end
  end
end
