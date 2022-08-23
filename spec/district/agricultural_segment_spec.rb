# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::AgriculturalSegment do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Agricultural Segment')
  end

  it 'provides 10 housing' do
    expect(district.housing).to eq(10)
  end

  it 'provides 10 Farmer jobs' do
    expect(district.max_jobs).to eq({ Job::Farmer => 10 })
  end

  it 'requires 5 Energy and 2 Volatile Motes' do
    expect(district.upkeep).to eq_resources({ energy: 5, volatile_motes: 2 })
  end
end
