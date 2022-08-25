# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::GovernorsEstates do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq("Governor's Estates")
  end

  it 'provides 10 housing' do
    expect(building.housing).to eq(10)
  end

  it 'provides 10 amenities' do
    expect(building.amenities_output).to eq(10)
  end

  it 'provides 10 stability' do
    expect(building.stability_modifier).to eq(10)
  end

  it 'provides 11 building slots and 2 branch office building slots' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 11 }, branch_office_building_slot: { additive: 2 } })
  end

  it 'provides 2 Politician jobs and 4 Overseer jobs' do
    expect(building.max_jobs).to eq({ Job::Politician => 2, Job::Overseer => 4 })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
