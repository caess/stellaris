require_relative '../stellaris/lib/stellaris'

RSpec.describe 'match checks' do
  context 'void dwellers tests' do
    let(:ruler) { Leader.new(level: 2) }
    let(:species) {
      Species.new(
        traits: [
          :void_dweller,
          :intelligent,
          :natural_engineers,
          :rapid_breeders,
          :deviants,
          :nonadaptive
        ],
        living_standard: :shared_burden,
      )
    }
    let(:empire) {
      Empire.new(
        founding_species: species,
        ruler: ruler,
        ethics: [:fanatic_egalitarian, :xenophile],
        civics: [:beacon_of_liberty, :shared_burdens],
        technology: {
          society: [
            :eco_simulation,
          ]
        },
      )
    }
    let(:governor) { Leader.new(level: 1) }
    let(:sector) {
      Sector.new(
        empire: empire,
        governor: governor
      )
    }

    describe "early game starting habitat" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :empire_capital,
          size: 6,
          sector: sector,
          districts: {
            habitation: 1,
            industrial: 2,
            research: 3,
          },
          buildings: {
            habitat_central_control: 1,
            administrative_offices: 1,
            holo_theatres: 1,
            civilian_industries: 1,
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
            alloys: 5 + 12,
          }
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to eq(-12)
        expect(net_output[:minerals]).to eq(-16)
        expect(net_output[:energy]).to eq(-1)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(12.96)
        expect(net_output[:alloys]).to be_within(0.1).of(20.94)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(39.88)
        expect(net_output[:physics_research]).to be_within(0.1).of(67.24)
        expect(net_output[:society_research]).to be_within(0.1).of(67.24)
        expect(net_output[:engineering_research]).to be_within(0.1).of(72.64)
        expect(net_output[:trade]).to be_within(0.1).of(6.71)
      end
    end

    describe "early game second habitat" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :mining_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            mining: 2,
          },
          buildings: {
            habitat_central_control: 1,
            hydroponics_farms: 1,
            civilian_industries: 1,
            holo_theatres: 1,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to be_within(0.1).of(10.17)
        expect(net_output[:minerals]).to be_within(0.1).of(20.49)
        expect(net_output[:energy]).to eq(-17)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(3.84)
        expect(net_output[:alloys]).to eq(-5)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(19.85)
        expect(net_output[:physics_research]).to eq(0)
        expect(net_output[:society_research]).to eq(0)
        expect(net_output[:engineering_research]).to eq(0)
        expect(net_output[:trade]).to be_within(0.1).of(4.73)
      end
    end

    describe "early game third habitat" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :generator_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            reactor: 2,
          },
          buildings: {
            habitat_central_control: 1,
            hydroponics_farms: 1,
            alloy_foundries: 1,
            holo_theatres: 1,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to be_within(0.1).of(10.17)
        expect(net_output[:minerals]).to eq(-12)
        expect(net_output[:energy]).to be_within(0.1).of(31.74)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(-12.4)
        expect(net_output[:alloys]).to be_within(0.1).of(3.12)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(19.85)
        expect(net_output[:physics_research]).to eq(0)
        expect(net_output[:society_research]).to eq(0)
        expect(net_output[:engineering_research]).to eq(0)
        expect(net_output[:trade]).to be_within(0.1).of(4.73)
      end
    end

    describe "early game energy habitat" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :generator_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            reactor: 2,
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            holo_theatres: 1,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to eq(-13)
        expect(net_output[:minerals]).to eq(-12)
        expect(net_output[:energy]).to be_within(0.1).of(34.39)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(-11.2)
        expect(net_output[:alloys]).to be_within(0.1).of(3.23)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(20.10)
        expect(net_output[:physics_research]).to eq(0)
        expect(net_output[:society_research]).to eq(0)
        expect(net_output[:engineering_research]).to eq(0)
        expect(net_output[:trade]).to be_within(0.1).of(3.90)
      end
    end

    describe "early game mining habitat" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :mining_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            mining: 2,
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            holo_theatres: 1,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to eq(-13)
        expect(net_output[:minerals]).to be_within(0.1).of(20.92)
        expect(net_output[:energy]).to eq(-15)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(-11.2)
        expect(net_output[:alloys]).to be_within(0.1).of(3.23)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(20.10)
        expect(net_output[:physics_research]).to eq(0)
        expect(net_output[:society_research]).to eq(0)
        expect(net_output[:engineering_research]).to eq(0)
        expect(net_output[:trade]).to be_within(0.1).of(3.90)
      end
    end

    describe "early game factory habitat" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :factory_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            industrial: 2,
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            civilian_industries: 1,
            holo_theatres: 1,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to eq(-13)
        expect(net_output[:minerals]).to be_within(0.1).of(-40.8)
        expect(net_output[:energy]).to eq(-17)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(38.19)
        expect(net_output[:alloys]).to be_within(0.1).of(3.23)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(20.10)
        expect(net_output[:physics_research]).to eq(0)
        expect(net_output[:society_research]).to eq(0)
        expect(net_output[:engineering_research]).to eq(0)
        expect(net_output[:trade]).to be_within(0.1).of(3.90)
      end
    end

    describe "early game foundry habitat" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :foundry_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            industrial: 2,
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            civilian_industries: 1,
            holo_theatres: 1,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to eq(-13)
        expect(net_output[:minerals]).to be_within(0.1).of(-40.8)
        expect(net_output[:energy]).to eq(-17)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(5.26)
        expect(net_output[:alloys]).to be_within(0.1).of(19.69)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(20.10)
        expect(net_output[:physics_research]).to eq(0)
        expect(net_output[:society_research]).to eq(0)
        expect(net_output[:engineering_research]).to eq(0)
        expect(net_output[:trade]).to be_within(0.1).of(3.90)
      end
    end

    describe "early game research habitat using districts" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :research_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 2,
            research: 2,
          },
          buildings: {
            habitat_central_control: 1,
            alloy_foundries: 1,
            holo_theatres: 1,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to eq(-13)
        expect(net_output[:minerals]).to eq(-12)
        expect(net_output[:energy]).to eq(-15)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(-23.2)
        expect(net_output[:alloys]).to be_within(0.1).of(3.23)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(20.10)
        expect(net_output[:physics_research]).to be_within(0.1).of(37.72)
        expect(net_output[:society_research]).to be_within(0.1).of(37.72)
        expect(net_output[:engineering_research]).to be_within(0.1).of(41.32)
        expect(net_output[:trade]).to be_within(0.1).of(3.90)
      end
    end

    describe "early game research habitat using buildings" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :research_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 3,
            leisure: 1,
          },
          buildings: {
            habitat_central_control: 1,
            research_labs: 4,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to eq(-14)
        expect(net_output[:minerals]).to eq(0)
        expect(net_output[:energy]).to eq(-19)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(-28.6)
        expect(net_output[:alloys]).to eq(-5)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(21.99)
        expect(net_output[:physics_research]).to be_within(0.1).of(51.07)
        expect(net_output[:society_research]).to be_within(0.1).of(51.07)
        expect(net_output[:engineering_research]).to be_within(0.1).of(55.87)
        expect(net_output[:trade]).to be_within(0.1).of(4.29)
      end
    end

    describe "early game unity habitat" do
      subject {
        Colony.new(
          type: :habitat,
          designation: :unification_station,
          size: 4,
          sector: sector,
          districts: {
            habitation: 3,
            leisure: 1,
          },
          buildings: {
            habitat_central_control: 1,
            administrative_offices: 4,
          },
          fill_jobs_with: species
        )
      }

      it "calculates the net output correctly" do
        net_output = subject.net_output
        expect(net_output[:food]).to eq(-14)
        expect(net_output[:minerals]).to eq(0)
        expect(net_output[:energy]).to eq(-19)
        expect(net_output[:consumer_goods]).to be_within(0.1).of(-27)
        expect(net_output[:alloys]).to eq(-5)
        expect(net_output[:exotic_gases]).to eq(0)
        expect(net_output[:rare_crystals]).to eq(0)
        expect(net_output[:volatile_motes]).to eq(0)
        expect(net_output[:unity]).to be_within(0.1).of(74.66)
        expect(net_output[:physics_research]).to eq(0)
        expect(net_output[:society_research]).to eq(0)
        expect(net_output[:engineering_research]).to eq(0)
        expect(net_output[:trade]).to be_within(0.1).of(4.29)
      end
    end
  end
end