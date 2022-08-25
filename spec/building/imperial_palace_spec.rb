# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::ImperialPalace do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Imperial Palace')
  end

  it 'provides 18 housing' do
    expect(building.housing).to eq(18)
  end

  it 'provides 18 amenities' do
    expect(building.amenities_output).to eq(18)
  end

  it 'provides 11 building slots and 4 branch office building slots' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 11 }, branch_office_building_slot: { additive: 4 } })
  end

  it 'provides 6 Politican jobs and 5 Enforcer jobs' do
    expect(building.max_jobs).to eq({ Job::Politician => 6, Job::Enforcer => 5 })
  end

  it 'requires 10 Energy' do
    expect(building.upkeep).to eq(ResourceGroup.new({ energy: 10 }))
  end
end
