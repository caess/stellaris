# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::ChamberOfElevation do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Chamber of Elevation')
  end

  it 'provides 1 Necrophyte job' do
    expect(building.max_jobs).to eq({ Job::Necrophyte => 1 })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
