# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::CitySegment do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('City Segment')
  end

  it 'provides 25 housing' do
    expect(district.housing).to eq(25)
  end

  it 'provides 3 Clerk and 2 Enforcer jobs' do
    expect(district.max_jobs).to eq({ Job::Clerk => 3, Job::Enforcer => 2 })
  end

  it 'requires 5 Energy' do
    expect(district.upkeep).to eq_resources({ energy: 5 })
  end
end
