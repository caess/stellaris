# frozen_string_literal: true

require_relative '../lib/empire'
require_relative '../lib/leader'
require_relative '../lib/mining_station'
require_relative '../lib/research_station'
require_relative '../lib/species'
require_relative '../lib/trade_deal'

RSpec.describe Empire do
  subject(:empire) do
    described_class.new(
      founder_species: species,
      ruler: ruler,
      ethics: [],
      civics: []
    )
  end

  let(:ruler) { Leader.new(level: 2) }
  let(:species) { Species.new(traits: [], living_standard: :decent_conditions) }

  describe 'stations' do
    it 'includes mining stations in its output' do
      station = MiningStation.new({ minerals: 10 })
      empire.add_station(station)
      expect(empire.output).to eq_resources({ minerals: 10 })
    end

    it 'includes mining stations in its upkeep' do
      station = MiningStation.new({ minerals: 10 })
      empire.add_station(station)
      expect(empire.upkeep).to eq_resources({ energy: 1 })
    end

    it 'includes research stations in its output' do
      station = ResearchStation.new({ physics_research: 10 })
      empire.add_station(station)
      expect(empire.output).to eq_resources({ physics_research: 10 })
    end

    it 'includes research stations in its upkeep' do
      station = ResearchStation.new({ physics_research: 10 })
      empire.add_station(station)
      expect(empire.upkeep).to eq_resources({ energy: 1 })
    end
  end

  describe 'trade deals' do
    let(:deal) { TradeDeal.new(ours: { consumer_goods: 10 }, theirs: { minerals: 20 }) }

    it 'includes trade deals in its output' do
      empire.add_trade_deal(deal)
      expect(empire.output).to eq_resources({ minerals: 20 })
    end

    it 'includes trade deals in its upkeep' do
      empire.add_trade_deal(deal)
      expect(empire.upkeep).to eq_resources({ consumer_goods: 10 })
    end
  end

  context 'when early game void dwellers' do
    include_context 'with empire' do
      let(:ruler) { Leader.new(level: 2) }
      let(:species_traits) do
        %i[
          void_dweller
          intelligent
          natural_engineers
          rapid_breeders
          deviants
          nonadaptive
        ]
      end
      let(:living_standard) { :shared_burden }
      let(:ethics) { %i[fanatic_egalitarian xenophile] }
      let(:civics) { %i[beacon_of_liberty shared_burdens] }
      let(:technology) { { society: [:eco_simulation] } }
      let(:governor) { Leader.new(level: 1) }
    end

    describe 'early game starting habitat' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :empire_capital,
          size: 6,
          sector: sector,
          districts: {
            habitation: 1,
            industrial: 2,
            research: 3
          },
          buildings: {
            habitat_central_control: 1,
            administrative_offices: 1,
            holo_theatres: 1,
            civilian_industries: 1
          },
          fill_jobs_with: species,
          deposits: {
            energy: 20,
            minerals: 20,
            food: 10,
            physics_research: 10,
            society_research: 10,
            engineering_research: 10,
            unity: 5,
            consumer_goods: 10 + 4,
            alloys: 5 + 12
          }
        )
      end

      it 'calculates the net Food output at -12' do
        expect(colony.net_output[:food]).to eq(-12)
      end

      it 'calculates the net Minerals output at -16' do
        expect(colony.net_output[:minerals]).to eq(-16)
      end

      it 'calculates the net Energy output at -1' do
        expect(colony.net_output[:energy]).to eq(-1)
      end

      it 'calculates the net Consumer Goods output at 12.96' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(12.96)
      end

      it 'calculates the net Alloys output at 20.94' do
        expect(colony.net_output[:alloys]).to be_within(0.01).of(20.94)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 39.88' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(39.88)
      end

      it 'calculates the net Physics Research output at 67.24' do
        expect(colony.net_output[:physics_research]).to be_within(0.01).of(67.24)
      end

      it 'calculates the net Society Research output at 67.24' do
        expect(colony.net_output[:society_research]).to be_within(0.01).of(67.24)
      end

      it 'calculates the net Engineering Research output at 72.64' do
        expect(colony.net_output[:engineering_research]).to be_within(0.01).of(72.64)
      end

      it 'calculates the net Trade output at 6.71' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(6.71)
      end
    end

    describe 'early game second habitat' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :mining_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            mining: 2
          },
          buildings: {
            habitat_central_control: 1,
            hydroponics_farms: 1,
            civilian_industries: 1,
            holo_theatres: 1
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at 10.17' do
        expect(colony.net_output[:food]).to be_within(0.01).of(10.17)
      end

      it 'calculates the net Minerals output at 20.49' do
        expect(colony.net_output[:minerals]).to be_within(0.01).of(20.49)
      end

      it 'calculates the net Energy output at -17' do
        expect(colony.net_output[:energy]).to eq(-17)
      end

      it 'calculates the net Consumer Goods output at 3.84' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(3.84)
      end

      it 'calculates the net Alloys output at -5' do
        expect(colony.net_output[:alloys]).to eq(-5)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 19.85' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(19.85)
      end

      it 'calculates the net Physics Research output at 0' do
        expect(colony.net_output[:physics_research]).to eq(0)
      end

      it 'calculates the net Society Research output at 0' do
        expect(colony.net_output[:society_research]).to eq(0)
      end

      it 'calculates the net Engineering Research output at 0' do
        expect(colony.net_output[:engineering_research]).to eq(0)
      end

      it 'calculates the net Trade output at 4.73' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(4.73)
      end
    end

    describe 'early game third habitat' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :generator_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            reactor: 2
          },
          buildings: {
            habitat_central_control: 1,
            hydroponics_farms: 1,
            alloy_foundries: 1,
            holo_theatres: 1
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at 10.17' do
        expect(colony.net_output[:food]).to be_within(0.01).of(10.17)
      end

      it 'calculates the net Minerals output at -12' do
        expect(colony.net_output[:minerals]).to eq(-12)
      end

      it 'calculates the net Energy output at 31.74' do
        expect(colony.net_output[:energy]).to be_within(0.01).of(31.74)
      end

      it 'calculates the net Consumer Goods output at -12.4' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(-12.4)
      end

      it 'calculates the net Alloys output at 3.12' do
        expect(colony.net_output[:alloys]).to be_within(0.01).of(3.12)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 19.85' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(19.85)
      end

      it 'calculates the net Physics Research output at 0' do
        expect(colony.net_output[:physics_research]).to eq(0)
      end

      it 'calculates the net Society Research output at 0' do
        expect(colony.net_output[:society_research]).to eq(0)
      end

      it 'calculates the net Engineering Research output at 0' do
        expect(colony.net_output[:engineering_research]).to eq(0)
      end

      it 'calculates the net Trade output at 4.73' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(4.73)
      end
    end

    describe 'early game energy habitat' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :generator_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            reactor: 2
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            holo_theatres: 1
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at -13' do
        expect(colony.net_output[:food]).to eq(-13)
      end

      it 'calculates the net Minerals output at -12' do
        expect(colony.net_output[:minerals]).to eq(-12)
      end

      it 'calculates the net Energy output at 34.39' do
        expect(colony.net_output[:energy]).to be_within(0.01).of(34.39)
      end

      it 'calculates the net Consumer Goods output at -11.2' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(-11.2)
      end

      it 'calculates the net Alloys output at 3.23' do
        expect(colony.net_output[:alloys]).to be_within(0.01).of(3.23)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 20.10' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(20.10)
      end

      it 'calculates the net Physics Research output at 0' do
        expect(colony.net_output[:physics_research]).to eq(0)
      end

      it 'calculates the net Society Research output at 0' do
        expect(colony.net_output[:society_research]).to eq(0)
      end

      it 'calculates the net Engineering Research output at 0' do
        expect(colony.net_output[:engineering_research]).to eq(0)
      end

      it 'calculates the net Trade output at 3.90' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(3.90)
      end
    end

    describe 'early game mining habitat' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :mining_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            mining: 2
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            holo_theatres: 1
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at -13' do
        expect(colony.net_output[:food]).to eq(-13)
      end

      it 'calculates the net Minerals output at 20.92' do
        expect(colony.net_output[:minerals]).to be_within(0.01).of(20.92)
      end

      it 'calculates the net Energy output at -15' do
        expect(colony.net_output[:energy]).to eq(-15)
      end

      it 'calculates the net Consumer Goods output at -11.2' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(-11.2)
      end

      it 'calculates the net Alloys output at 3.23' do
        expect(colony.net_output[:alloys]).to be_within(0.01).of(3.23)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 20.10' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(20.10)
      end

      it 'calculates the net Physics Research output at 0' do
        expect(colony.net_output[:physics_research]).to eq(0)
      end

      it 'calculates the net Society Research output at 0' do
        expect(colony.net_output[:society_research]).to eq(0)
      end

      it 'calculates the net Engineering Research output at 0' do
        expect(colony.net_output[:engineering_research]).to eq(0)
      end

      it 'calculates the net Trade output at 3.90' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(3.90)
      end
    end

    describe 'early game factory habitat' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :factory_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            industrial: 2
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            civilian_industries: 1,
            holo_theatres: 1
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at -13' do
        expect(colony.net_output[:food]).to eq(-13)
      end

      it 'calculates the net Minerals output at -40.8' do
        expect(colony.net_output[:minerals]).to be_within(0.01).of(-40.8)
      end

      it 'calculates the net Energy output at -17' do
        expect(colony.net_output[:energy]).to eq(-17)
      end

      it 'calculates the net Consumer Goods output at 38.19' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(38.19)
      end

      it 'calculates the net Alloys output at 3.23' do
        expect(colony.net_output[:alloys]).to be_within(0.01).of(3.23)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 20.10' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(20.10)
      end

      it 'calculates the net Physics Research output at 0' do
        expect(colony.net_output[:physics_research]).to eq(0)
      end

      it 'calculates the net Society Research output at 0' do
        expect(colony.net_output[:society_research]).to eq(0)
      end

      it 'calculates the net Engineering Research output at 0' do
        expect(colony.net_output[:engineering_research]).to eq(0)
      end

      it 'calculates the net Trade output at 3.90' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(3.90)
      end
    end

    describe 'early game foundry habitat' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :foundry_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            industrial: 2
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            civilian_industries: 1,
            holo_theatres: 1
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at -13' do
        expect(colony.net_output[:food]).to eq(-13)
      end

      it 'calculates the net Minerals output at -40.8' do
        expect(colony.net_output[:minerals]).to be_within(0.01).of(-40.8)
      end

      it 'calculates the net Energy output at -17' do
        expect(colony.net_output[:energy]).to eq(-17)
      end

      it 'calculates the net Consumer Goods output at 5.26' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(5.26)
      end

      it 'calculates the net Alloys output at 19.69' do
        expect(colony.net_output[:alloys]).to be_within(0.01).of(19.69)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 20.10' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(20.10)
      end

      it 'calculates the net Physics Research output at 0' do
        expect(colony.net_output[:physics_research]).to eq(0)
      end

      it 'calculates the net Society Research output at 0' do
        expect(colony.net_output[:society_research]).to eq(0)
      end

      it 'calculates the net Engineering Research output at 0' do
        expect(colony.net_output[:engineering_research]).to eq(0)
      end

      it 'calculates the net Trade output at 3.90' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(3.90)
      end
    end

    describe 'early game research habitat using districts' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :research_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            research: 2
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            holo_theatres: 1
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at -13' do
        expect(colony.net_output[:food]).to eq(-13)
      end

      it 'calculates the net Minerals output at -12' do
        expect(colony.net_output[:minerals]).to eq(-12)
      end

      it 'calculates the net Energy output at -15' do
        expect(colony.net_output[:energy]).to eq(-15)
      end

      it 'calculates the net Consumer Goods output at -23.2' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(-23.2)
      end

      it 'calculates the net Alloys output at 3.23' do
        expect(colony.net_output[:alloys]).to be_within(0.01).of(3.23)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 20.10' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(20.10)
      end

      it 'calculates the net Physics Research output at 37.72' do
        expect(colony.net_output[:physics_research]).to be_within(0.01).of(37.72)
      end

      it 'calculates the net Society Research output at 37.72' do
        expect(colony.net_output[:society_research]).to be_within(0.01).of(37.72)
      end

      it 'calculates the net Engineering Research output at 41.32' do
        expect(colony.net_output[:engineering_research]).to be_within(0.01).of(41.32)
      end

      it 'calculates the net Trade output at 3.90' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(3.90)
      end
    end

    describe 'early game research habitat using buildings' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :research_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 3,
            leisure: 1
          },
          buildings: {
            habitat_central_control: 1,
            research_labs: 4
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at -14' do
        expect(colony.net_output[:food]).to eq(-14)
      end

      it 'calculates the net Minerals output at 0' do
        expect(colony.net_output[:minerals]).to eq(0)
      end

      it 'calculates the net Energy output at -19' do
        expect(colony.net_output[:energy]).to eq(-19)
      end

      it 'calculates the net Consumer Goods output at -28.6' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(-28.6)
      end

      it 'calculates the net Alloys output at -5' do
        expect(colony.net_output[:alloys]).to eq(-5)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 21.99' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(21.99)
      end

      it 'calculates the net Physics Research output at 51.07' do
        expect(colony.net_output[:physics_research]).to be_within(0.01).of(51.07)
      end

      it 'calculates the net Society Research output at 51.07' do
        expect(colony.net_output[:society_research]).to be_within(0.01).of(51.07)
      end

      it 'calculates the net Engineering Research output at 55.87' do
        expect(colony.net_output[:engineering_research]).to be_within(0.01).of(55.87)
      end

      it 'calculates the net Trade output at 4.29' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(4.29)
      end
    end

    describe 'early game unity habitat' do
      let(:colony) do
        Colony.new(
          type: :habitat,
          designation: :unification_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 3,
            leisure: 1
          },
          buildings: {
            habitat_central_control: 1,
            administrative_offices: 4
          },
          fill_jobs_with: species
        )
      end

      it 'calculates the net Food output at -14' do
        expect(colony.net_output[:food]).to eq(-14)
      end

      it 'calculates the net Minerals output at 0' do
        expect(colony.net_output[:minerals]).to eq(0)
      end

      it 'calculates the net Energy output at -19' do
        expect(colony.net_output[:energy]).to eq(-19)
      end

      it 'calculates the net Consumer Goods output at -27' do
        expect(colony.net_output[:consumer_goods]).to be_within(0.01).of(-27)
      end

      it 'calculates the net Alloys output at -5' do
        expect(colony.net_output[:alloys]).to eq(-5)
      end

      it 'calculates the net Exotic Gases output at 0' do
        expect(colony.net_output[:exotic_gases]).to eq(0)
      end

      it 'calculates the net Rare Crystals output at 0' do
        expect(colony.net_output[:rare_crystals]).to eq(0)
      end

      it 'calculates the net Volatile Motes output at 0' do
        expect(colony.net_output[:volatile_motes]).to eq(0)
      end

      it 'calculates the net Unity output at 74.66' do
        expect(colony.net_output[:unity]).to be_within(0.01).of(74.66)
      end

      it 'calculates the net Physics Research output at 0' do
        expect(colony.net_output[:physics_research]).to eq(0)
      end

      it 'calculates the net Society Research output at 0' do
        expect(colony.net_output[:society_research]).to eq(0)
      end

      it 'calculates the net Engineering Research output at 0' do
        expect(colony.net_output[:engineering_research]).to eq(0)
      end

      it 'calculates the net Trade output at 4.29' do
        expect(colony.net_output[:trade]).to be_within(0.01).of(4.29)
      end
    end
  end

  context 'when checking early void dweller empire' do
    include_context 'with empire' do
      let(:ruler) { Leader.new(level: 2, traits: %i[explorer industrialist]) }
      let(:species_traits) do
        %i[
          void_dweller
          intelligent
          natural_engineers
          rapid_breeders
          deviants
          nonadaptive
        ]
      end
      let(:living_standard) { :shared_burden }
      let(:ethics) { %i[fanatic_egalitarian xenophile] }
      let(:civics) { %i[beacon_of_liberty shared_burdens] }
      let(:technology) { { society: [:eco_simulation] } }
      let(:governor) { Leader.new(level: 1, traits: [:unifier]) }
    end

    before do
      Colony.new(
        type: :habitat,
        designation: :empire_capital,
        size: 6,
        sector: sector,
        districts: {
          habitation: 1,
          industrial: 2,
          research: 1
        },
        buildings: {
          habitat_central_control: 1,
          administrative_offices: 1,
          holo_theatres: 1,
          alloy_foundries: 0
        },
        jobs: {
          politician: { species => 2 },
          researcher: { species => 0 },
          enforcer: { species => 1 },
          entertainer: { species => 1 },
          bureaucrat: { species => 2 },
          metallurgist: { species => 2 },
          artisan: { species => 2 }
        },
        deposits: {
          energy: 20,
          minerals: 20,
          food: 10,
          physics_research: 10,
          society_research: 10,
          engineering_research: 10,
          unity: 5,
          consumer_goods: 10 + 4,
          alloys: 5 + 12
        }
      )

      Colony.new(
        type: :habitat,
        designation: :mining_station,
        size: 4,
        sector: sector,
        districts: {
          habitation: 1,
          trade: 1,
          mining: 1
        },
        buildings: {
          habitat_administration: 1,
          hydroponics_farms: 1
        },
        jobs: {
          colonist: { species => 2 },
          clerk: { species => 1 },
          miner: { species => 3 },
          farmer: { species => 3 }
        }
      )

      Colony.new(
        type: :habitat,
        designation: :generator_station,
        size: 4,
        sector: sector,
        districts: {
          habitation: 1,
          trade: 1,
          reactor: 1
        },
        buildings: {
          habitat_administration: 1,
          hydroponics_farms: 1
        },
        jobs: {
          colonist: { species => 2 },
          clerk: { species => 1 },
          technician: { species => 3 },
          farmer: { species => 3 }
        }
      )
    end

    describe 'empire output' do
      it 'produces 40.54 unity' do
        expect(empire.output[:unity]).to be_within(0.01).of(40.54)
      end

      it 'produces 62.4 food' do
        expect(empire.output[:food]).to be_within(0.01).of(62.4)
      end

      it 'produces 37.84 minerals' do
        expect(empire.output[:minerals]).to be_within(0.01).of(37.84)
      end

      it 'produces 41.96 energy' do
        expect(empire.output[:energy]).to be_within(0.01).of(41.96)
      end

      it 'produces 32.31 consumer goods' do
        expect(empire.output[:consumer_goods]).to be_within(0.01).of(32.31)
      end

      it 'produces 26.15 alloys' do
        expect(empire.output[:alloys]).to be_within(0.01).of(26.15)
      end

      it 'produces 0 volatile motes' do
        expect(empire.output[:volatile_motes]).to eq(0)
      end

      it 'produces 0 exotic gases' do
        expect(empire.output[:exotic_gases]).to eq(0)
      end

      it 'produces 0 rare crystals' do
        expect(empire.output[:rare_crystals]).to eq(0)
      end

      it 'produces 10 physics research' do
        expect(empire.output[:physics_research]).to eq(10)
      end

      it 'produces 10 society research' do
        expect(empire.output[:society_research]).to eq(10)
      end

      it 'produces 10 engineering research' do
        expect(empire.output[:engineering_research]).to eq(10)
      end

      it 'produces 16.26 trade' do
        expect(empire.output[:trade]).to be_within(0.01).of(16.26)
      end
    end
  end
end
