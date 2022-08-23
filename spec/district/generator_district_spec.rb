# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::GeneratorDistrict do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Generator District')
  end

  it 'provides 2 housing' do
    expect(district.housing).to eq(2)
  end

  it 'provides 2 Technician jobs' do
    expect(district.max_jobs).to eq({ Job::Technician => 2 })
  end

  it 'requires 1 Energy' do
    expect(district.upkeep).to eq_resources({ energy: 1 })
  end
end
