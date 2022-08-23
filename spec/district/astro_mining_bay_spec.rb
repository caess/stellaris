# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::AstroMiningBay do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Astro-Mining Bay')
  end

  it 'provides 3 housing' do
    expect(district.housing).to eq(3)
  end

  it 'provides 3 Miner jobs' do
    expect(district.max_jobs).to eq({ Job::Miner => 3 })
  end

  it 'requires 2 Energy' do
    expect(district.upkeep).to eq_resources({ energy: 2 })
  end
end
