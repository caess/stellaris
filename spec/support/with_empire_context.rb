# frozen_string_literal: true

require_relative '../../lib/colony'
require_relative '../../lib/empire'
require_relative '../../lib/leader'
require_relative '../../lib/sector'
require_relative '../../lib/species'

# rubocop:disable RSpec/MultipleMemoizedHelpers

RSpec.shared_context 'with empire' do
  let(:species_traits) { [] }
  let(:species) do
    Species.new(
      living_standard: nil,
      traits: species_traits
    )
  end
  let(:ruler) { Leader.new(level: 0) }
  let(:traditions) { [] }
  let(:civics) { [] }
  let(:technologies) { [] }
  let(:empire) do
    Empire.new(
      founder_species: species,
      ruler: Leader.new(level: 0),
      traditions: traditions,
      civics: civics,
      technologies: technologies
    )
  end
  let(:governor) { Leader.new(level: 0) }
  let(:sector) { Sector.new(empire: empire, governor: governor) }
  let(:colony_jobs) { {} }
  let(:colony) do
    colony = Colony.new(type: nil, size: nil, sector: sector, jobs: colony_jobs)
    allow(colony).to receive(:stability_coefficient_modifier).and_return(ResourceModifier::NONE)
    colony
  end
end

# rubocop:enable RSpec/MultipleMemoizedHelpers
