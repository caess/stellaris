# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::SystemCapitalComplex do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('System Capital-Complex')
  end

  it 'provides 12 housing' do
    expect(building.housing).to eq(12)
  end

  it 'provides 12 amenities' do
    expect(building.amenities_output).to eq(12)
  end

  it 'provides 4 building slots and 4 branch office building slots' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ building_slot: { additive: 4 }, branch_office_building_slot: { additive: 4 } })
  end

  it 'provides 4 Politician jobs and 3 Enforcer jobs' do
    expect(building.max_jobs).to eq({ Job::Politician => 4, Job::Enforcer => 3 })
  end

  it 'requires 10 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 10 })
  end
end
