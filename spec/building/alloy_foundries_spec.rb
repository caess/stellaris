# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Building::AlloyFoundries do
  subject(:building) { described_class }

  it 'has the name Alloy Foundries' do
    expect(building.name).to eq('Alloy Foundries')
  end

  it 'provides 2 Metallurgist jobs' do
    expect(building.max_jobs).to eq({ Job::Metallurgist => 2 })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
