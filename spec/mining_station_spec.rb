# frozen_string_literal: true

require_relative '../lib/mining_station'
require_relative '../lib/resource_modifier'

RSpec.describe MiningStation do
  subject(:station) { described_class.new({ minerals: 10 }) }

  let(:empire) do
    empire = Object.new
    class << empire
      def mining_station_modifiers
        ResourceModifier.new({ minerals: { multiplicative: 0.1 } })
      end
    end

    empire
  end

  it 'provides its resources' do
    expect(station.output).to eq_resources({ minerals: 10 })
  end

  it 'requires its upkeep' do
    expect(station.upkeep).to eq_resources({ energy: 1 })
  end

  it 'has its output modified by the empire' do
    station.empire = empire

    expect(station.output).to eq_resources({ minerals: 11 })
  end

  describe 'when energy station' do
    subject(:station) { described_class.new({ energy: 10 }) }

    it 'has no upkeep' do
      expect(station.upkeep).to eq_resources({ energy: 0 })
    end
  end
end
