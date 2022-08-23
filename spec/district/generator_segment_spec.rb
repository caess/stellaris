# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::GeneratorSegment do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Generator Segment')
  end

  it 'provides 10 housing' do
    expect(district.housing).to eq(10)
  end

  it 'provides 10 Technician jobs' do
    expect(district.max_jobs).to eq({ Job::Technician => 10 })
  end

  it 'requires 5 Energy and 2 Rare Crystals' do
    expect(district.upkeep).to eq_resources({ energy: 5, rare_crystals: 2 })
  end
end
