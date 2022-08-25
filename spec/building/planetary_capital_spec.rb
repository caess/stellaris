# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::PlanetaryCapital do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Planetary Capital')
  end

  it 'provides 8 housing' do
    expect(building.housing).to eq(8)
  end

  it 'provides 8 amenities' do
    expect(building.amenities_output).to eq(8)
  end

  it 'provides 3 building slots and 2 branch office building slots' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 3 }, branch_office_building_slot: { additive: 2 } })
  end

  it 'provides 2 Politician jobs and 2 Enforcer jobs' do
    expect(building.max_jobs).to eq({ Job::Politician => 3, Job::Enforcer => 2 })
  end

  it 'requires 8 Energy' do
    expect(building.upkeep).to eq(ResourceGroup.new({ energy: 8 }))
  end
end
