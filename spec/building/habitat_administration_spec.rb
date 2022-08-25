# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::HabitatAdministration do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Habitat Administration')
  end

  it 'provides 3 housing' do
    expect(building.housing).to eq(3)
  end

  it 'provides 3 amenities' do
    expect(building.amenities_output).to eq(3)
  end

  it 'provides 1 building slot' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 1 } })
  end

  it 'provides 1 Politician job' do
    expect(building.max_jobs).to eq({ Job::Politician => 1 })
  end

  it 'requires 3 Energy and 5 Alloys' do
    expect(building.upkeep)
      .to eq_resources({ energy: 3, alloys: 5 })
  end
end
