# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::PlanetaryAdministration do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Planetary Administration')
  end

  it 'provides 5 housing' do
    expect(building.housing).to eq(5)
  end

  it 'provides 5 amenities' do
    expect(building.amenities_output).to eq(5)
  end

  it 'provides 2 building slots and 1 branch office building slot' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 2 }, branch_office_building_slot: { additive: 1 } })
  end

  it 'provides 2 Politician jobs and 1 Enforcer job' do
    expect(building.max_jobs).to eq({ Job::Politician => 2, Job::Enforcer => 1 })
  end

  it 'requires 5 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 5 })
  end
end
