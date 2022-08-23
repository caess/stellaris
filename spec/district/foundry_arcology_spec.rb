# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::FoundryArcology do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Foundry Arcology')
  end

  it 'provides 10 housing' do
    expect(district.housing).to eq(10)
  end

  it 'provides 6 Metallurgist jobs' do
    expect(district.max_jobs).to eq({ Job::Metallurgist => 6 })
  end

  it 'requires 5 Energy and 1 Volatile Mote' do
    expect(district.upkeep).to eq_resources({ energy: 5, volatile_motes: 1 })
  end
end
