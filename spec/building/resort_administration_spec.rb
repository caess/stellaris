# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::ResortAdministration do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Resort Administration')
  end

  it 'provides 5 housing' do
    expect(building.housing).to eq(5)
  end

  it 'provides 5 amenities' do
    expect(building.amenities_output).to eq(5)
  end

  it 'provides 5 building slots and 1 branch office building slot' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 5 }, branch_office_building_slot: { additive: 1 } })
  end

  it 'provides 1 Politician job and 1 Enforcer job' do
    expect(building.max_jobs).to eq({ Job::Politician => 1, Job::Entertainer => 1 })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
