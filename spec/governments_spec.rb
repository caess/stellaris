require_relative "../stellaris/lib/stellaris"

RSpec.describe "governments" do
  describe "Hive Mind" do
    subject { Government::HiveMind }

    it "has the correct name" do
      expect(subject.name).to eq("Hive Mind")
    end

    it "modifies the Necrophyte job upkeep" do
      pop_job = PopJob.new(worker: nil, job: Job::Necrophyte)

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(
        ResourceModifier.new(
          consumer_goods: { additive: -1 },
          food: { multiplicative: 1 },
          minerals: { multiplicative: 1 },
        )
      )
    end
  end

  describe "Machine Intelligence" do
    subject { Government::MachineIntelligence }

    it "has the correct name" do
      expect(subject.name).to eq("Machine Intelligence")
    end

    it "modifies the Agri-Drone job output" do
      pop_job = PopJob.new(worker: nil, job: Job::AgriDrone)

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ food: { additive: -1 } })
      )
    end
  end
end

RSpec.describe "end-to-end tests" do
  let(:species) do
    Species.new(
      living_standard: nil,
    )
  end
  let(:lithoid_species) do
    Species.new(
      living_standard: nil,
      traits: [SpeciesTrait::Lithoid],
    )
  end
  let(:ruler) { Leader.new(level: 0) }

  describe "Hive Mind" do
    let(:empire) do
      Empire.new(
        founder_species: species,
        ruler: ruler,
        government: Government::HiveMind,
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

    context "biological pops" do
      it "modifies the upkeep of Necrophytes" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Necrophyte,
        )

        expect(pop.job.upkeep).to eq(ResourceGroup.new(
          food: 2,
        ))
      end
    end

    context "lithoid pops" do
      it "modifies the upkeep of Necrophytes" do
        pop = Pop.new(
          species: lithoid_species,
          colony: colony,
          job: Job::Necrophyte,
        )

        expect(pop.job.upkeep).to eq(ResourceGroup.new(
          minerals: 2,
        ))
      end
    end
  end

  describe "Machine Intelligence" do
    let(:empire) do
      Empire.new(
        founder_species: species,
        ruler: ruler,
        government: Government::MachineIntelligence,
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

    it "modifies the output of Agri-Drones" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::AgriDrone,
      )

      expect(pop.job.output).to eq(ResourceGroup.new(
        food: 5,
      ))
    end
  end
end
