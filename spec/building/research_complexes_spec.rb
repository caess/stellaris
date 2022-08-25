# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::ResearchComplexes do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Research Complexes')
  end

  it 'provides 4 Researcher jobs' do
    expect(building.max_jobs).to eq({ Job::Researcher => 4 })
  end

  it 'requires 5 Energy and 1 Exotic Gas' do
    expect(building.upkeep).to eq_resources({ energy: 5, exotic_gases: 1 })
  end
end
