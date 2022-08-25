# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::LuxuryResidences do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Luxury Residences')
  end

  it 'proivdes 3 housing' do
    expect(building.housing).to eq(3)
  end

  it 'provides 5 amenities' do
    expect(building.amenities_output).to eq(5)
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
