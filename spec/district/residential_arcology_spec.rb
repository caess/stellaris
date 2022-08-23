# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::ResidentialArcology do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Residential Arcology')
  end

  it 'provides 15 housing' do
    expect(district.housing).to eq(15)
  end

  it 'provides 3 Clerk jobs' do
    expect(district.max_jobs).to eq({ Job::Clerk => 3 })
  end

  it 'requires 5 Energy' do
    expect(district.upkeep).to eq_resources({ energy: 5 })
  end
end
