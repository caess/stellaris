# frozen_string_literal: true

require 'colony'
require 'empire'
require 'leader'
require 'sector'
require 'species'

RSpec.shared_context 'default empire' do
  let(:species) do
    Species.new(
      living_standard: nil
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
  let(:colony) do
    colony = Colony.new(type: nil, size: nil, sector: sector)
    allow(colony).to receive(:stability_coefficient_modifier).and_return(ResourceModifier::NONE)
    colony
  end
end
