# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::AdministrativePark do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Administrative Park')
  end

  it 'provides 4 Bureaucrat jobs' do
    expect(building.max_jobs).to eq({ Job::Bureaucrat => 4 })
  end

  it 'requires 5 Energy and 1 Rare Crystal' do
    expect(building.upkeep).to eq_resources({ energy: 5, rare_crystals: 1 })
  end
end
