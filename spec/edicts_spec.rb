require_relative "../stellaris/lib/stellaris"

RSpec.describe "edicts" do
  describe "Forge Subsidies" do
    subject { Edict::ForgeSubsidies }

    it "has the correct name" do
      expect(subject.name).to eq("Forge Subsidies")
    end

    it "increases the upkeep for metallurgists" do
      job = instance_double("Job")

      expect(job).to receive(:metallurgist?).and_return(true)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(ResourceModifier.new({
        energy: { additive: 1 },
      }))
    end
  end

  describe "Industrial Subsidies" do
    subject { Edict::IndustrialSubsidies }

    it "has the correct name" do
      expect(subject.name).to eq("Industrial Subsidies")
    end

    it "increases the upkeep for artisans" do
      job = instance_double("Job")

      expect(job).to receive(:artisan?).and_return(true)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(ResourceModifier.new({
        energy: { additive: 1 },
      }))
    end
  end
end

RSpec.describe "end-to-end tests" do
  let(:species) do
    Species.new(
      living_standard: nil,
    )
  end
  let(:ruler) { Leader.new(level: 0) }

  describe "Forge Subsidies" do
    let(:empire) do
      Empire.new(
        founding_species: species,
        ruler: ruler,
        edicts: [Edict::ForgeSubsidies],
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

    it "modifies the upkeep of Metallurgists" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Metallurgist
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        minerals: 6,
        energy: 1,
      }))
    end

    it "modifies the upkeep of Catalytic Technicians" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::CatalyticTechnician
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        food: 9,
        energy: 1,
      }))
    end
  end

  describe "Industrial Subsidies" do
    let(:empire) do
      Empire.new(
        founding_species: species,
        ruler: ruler,
        edicts: [Edict::IndustrialSubsidies],
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

    it "modifies the upkeep of Artisans" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Artisan
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        minerals: 6,
        energy: 1,
      }))
    end

    it "modifies the upkeep of Artificers" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Artificer
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        minerals: 6,
        energy: 1,
      }))
    end

    it "modifies the upkeep of Pearl Divers" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::PearlDiver
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        food: 2,
        minerals: 2,
        energy: 1,
      }))
    end
  end
end