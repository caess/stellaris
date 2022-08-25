# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::HouseOfApotheosis do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('House of Apotheosis')
  end

  it 'provides 6 Necrophyte jobs' do
    expect(building.max_jobs).to eq({ Job::Necrophyte => 6 })
  end

  it 'requires 5 Energy and 1 Exotic Gas' do
    expect(building.upkeep).to eq_resources({ energy: 5, exotic_gases: 1 })
  end
end
