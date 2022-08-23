# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::IndustrialDistrict do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Industrial District')
  end

  it 'provides 2 housing' do
    expect(district.housing).to eq(2)
  end

  it 'provides 1 Artisan job and 1 Metallurgist job' do
    expect(district.max_jobs).to eq({ Job::Artisan => 1, Job::Metallurgist => 1 })
  end

  it 'requires 2 Energy' do
    expect(district.upkeep).to eq_resources({ energy: 2 })
  end
end
