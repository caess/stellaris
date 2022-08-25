# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::ReassembledShipShelter do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Reassembled Ship Shelter')
  end

  it 'provides 3 housing' do
    expect(building.housing).to eq(3)
  end

  it 'provides 7 amenities' do
    expect(building.amenities_output).to eq(7)
  end

  it 'provides 1 building slot' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 1 } })
  end

  it 'provides 2 Colonist jobs' do
    expect(building.max_jobs).to eq({ Job::Colonist => 2 })
  end

  it 'requires 1 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 1 })
  end
end
