# frozen_string_literal: true

require_relative '../../lib/colony'
require_relative '../../lib/empire'
require_relative '../../lib/leader'
require_relative '../../lib/sector'
require_relative '../../lib/species'

# rubocop:disable RSpec/MultipleMemoizedHelpers

RSpec.shared_context 'with empire' do
  let(:species_traits) { [] }
  let(:founder_species_traits) { [] }
  let(:living_standard) { nil }
  let(:species) do
    Species.new(
      living_standard: living_standard,
      traits: species_traits
    )
  end
  let(:founder_species) do
    Species.new(
      living_standard: living_standard,
      traits: founder_species_traits
    )
  end
  let(:ruler) { Leader.new(level: 0) }
  let(:traditions) { [] }
  let(:ethics) { {} }
  let(:civics) { [] }
  let(:edicts) { [] }
  let(:technologies) { [] }
  let(:technology) { {} }
  let(:government) { nil }
  let(:empire) do
    Empire.new(
      founder_species: founder_species,
      ruler: ruler,
      government: government,
      traditions: traditions,
      ethics: ethics,
      civics: civics,
      edicts: edicts,
      technology: technology,
      technologies: technologies
    )
  end
  let(:governor) { Leader.new(level: 0) }
  let(:sector) { Sector.new(empire: empire, governor: governor) }
  let(:colony_jobs) { {} }
  let(:colony_modifiers) { [] }
  let(:colony) do
    colony = Colony.new(type: nil, size: nil, sector: sector, jobs: colony_jobs, decisions: colony_modifiers)
    allow(colony).to receive(:stability_coefficient).and_return(0)
    colony
  end
end

# rubocop:enable RSpec/MultipleMemoizedHelpers
