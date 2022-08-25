# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::ParadiseDome do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Paradise Dome')
  end

  it 'proivdes 6 housing' do
    expect(building.housing).to eq(6)
  end

  it 'provides 10 amenities' do
    expect(building.amenities_output).to eq(10)
  end

  it 'requires 5 Energy and 1 Rare Crystal' do
    expect(building.upkeep).to eq_resources({ energy: 5, rare_crystals: 1 })
  end
end
