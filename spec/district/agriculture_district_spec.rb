# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::AgricultureDistrict do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Agriculture District')
  end

  it 'provides 2 housing' do
    expect(district.housing).to eq(2)
  end

  it 'provides 2 Farmer jobs' do
    expect(district.max_jobs).to eq({ Job::Farmer => 2 })
  end

  it 'requires 1 Energy' do
    expect(district.upkeep).to eq_resources({ energy: 1 })
  end
end
