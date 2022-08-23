# frozen_string_literal: true

require_relative '../../lib/district'
require_relative '../../lib/job'

RSpec.describe District::HabitationDistrict do
  subject(:district) { described_class }

  it 'has the correct name' do
    expect(district.name).to eq('Habitation District')
  end

  it 'provides 8 housing' do
    expect(district.housing).to eq(8)
  end

  it 'provides no jobs' do
    expect(district.max_jobs).to eq({})
  end

  it 'requires 2 Energy' do
    expect(district.upkeep).to eq_resources({ energy: 2 })
  end
end
