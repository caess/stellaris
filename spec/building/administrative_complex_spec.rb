# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::AdministrativeComplex do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Administrative Complex')
  end

  it 'provides 6 Bureaucrat jobs' do
    expect(building.max_jobs).to eq({ Job::Bureaucrat => 6 })
  end

  it 'requires 8 Energy and 2 Rare Crystals' do
    expect(building.upkeep).to eq_resources({ energy: 8, rare_crystals: 2 })
  end
end
