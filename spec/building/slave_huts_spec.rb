# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::SlaveHuts do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Slave Huts')
  end

  it 'proivdes 8 housing' do
    expect(building.housing).to eq(8)
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
