# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Building::CivilianIndustries do
  subject(:building) { described_class }

  it 'has the name Civilian Industries' do
    expect(building.name).to eq('Civilian Industries')
  end

  it 'provides 2 Artisan jobs' do
    expect(building.max_jobs).to eq({ Job::Artisan => 2 })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
