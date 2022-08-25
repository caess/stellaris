# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::HoloTheatres do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Holo-Theatres')
  end

  it 'provides 2 Entertainer jobs' do
    expect(building.max_jobs).to eq({ Job::Entertainer => 2 })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
