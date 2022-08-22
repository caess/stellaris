# frozen_string_literal: true

require_relative '../lib/research_station'
require_relative '../lib/resource_modifier'

RSpec.describe ResearchStation do
  subject(:station) { described_class.new({ physics_research: 10 }) }

  let(:empire) do
    empire = Object.new
    class << empire
      def research_station_modifiers
        ResourceModifier.new({ physics_research: { multiplicative: 0.1 } })
      end
    end

    empire
  end

  it 'provides its resources' do
    expect(station.output).to eq_resources({ physics_research: 10 })
  end

  it 'requires its upkeep' do
    expect(station.upkeep).to eq_resources({ energy: 1 })
  end

  it 'has its output modified by the empire' do
    station.empire = empire

    expect(station.output).to eq_resources({ physics_research: 11 })
  end
end
