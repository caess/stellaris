# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::AdvancedResearchComplexes do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Advanced Research Complexes')
  end

  it 'provides 6 Researcher jobs' do
    expect(building.max_jobs).to eq({ Job::Researcher => 6 })
  end

  it 'requires 8 Energy and 2 Exotic Gases' do
    expect(building.upkeep).to eq_resources({ energy: 8, exotic_gases: 2 })
  end
end
