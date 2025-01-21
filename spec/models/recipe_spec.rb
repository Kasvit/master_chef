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
      expect(subject.name).to eq("Grilled Chicken")
    end

    it 'has a description' do
      expect(subject.description).to eq("A delicious Grilled Chicken.")
    end

    it 'has ingredients' do
      expect(subject.ingredients).to eq("chicken, salt, pepper")
    end

    it 'has instructions' do
      expect(subject.instructions).to eq([ { step: "Prepare the Chicken", description: "Rinse the chicken under cold water, pat it dry with paper towels" }, { step: "Season the Chicken", description: "Sprinkle salt and pepper evenly over both sides of the chicken" }, { step: "Grill the Chicken", description: "Place the chicken on a preheated grill and cook for about 5-6 minutes per side, or until it reaches an internal temperature of 165°F" }, { step: "Rest the Chicken", description: "Once cooked, remove the chicken from the grill and let it rest for a few minutes before serving" } ])
    end

    it 'has cooking time' do
      expect(subject.cooking_time).to eq("20 minutes")
    end

    it 'has an error message' do
      expect(subject.error).to eq("")
    end
  end
end
