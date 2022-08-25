# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::GovernorsPalace do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq("Governor's Palace")
  end

  it 'provides 5 housing' do
    expect(building.housing).to eq(5)
  end

  it 'provides 5 amenities' do
    expect(building.amenities_output).to eq(5)
  end

  it 'provides 5 stability' do
    expect(building.stability_modifier).to eq(5)
  end

  it 'provides 5 building slots and 1 branch office building slot' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 5 }, branch_office_building_slot: { additive: 1 } })
  end

  it 'provides 2 Politician jobs and 2 Overseer jobs' do
    expect(building.max_jobs).to eq({ Job::Politician => 2, Job::Overseer => 2 })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
