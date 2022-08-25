# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::PlanetaryShieldGenerator do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Planetary Shield Generator')
  end

  it 'reduces orbital bombardment damage by 50%' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ orbital_bombardment_damage_multiplier: { additive: -0.5 } })
  end
end
