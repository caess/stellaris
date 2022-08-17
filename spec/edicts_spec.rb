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

  describe "Capacity Subsidies" do
    subject { Edict::CapacitySubsidies }

    it "has the correct name" do
      expect(subject.name).to eq("Capacity Subsidies")
    end

    it "increases the upkeep for Technicians" do
      pop_job = PopJob.new(worker: nil, job: Job::Technician)

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(ResourceModifier.new({
        energy: { additive: 0.5 },
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

  describe "Mining Subsidies" do
    subject { Edict::MiningSubsidies }

    it "has the correct name" do
      expect(subject.name).to eq("Mining Subsidies")
    end

    it "increases the upkeep for miners" do
      job = instance_double("Job")

      expect(job).to receive(:miner?).and_return(true)

      pop_job = PopJob.new(worker: nil, job: job)

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(ResourceModifier.new({
        energy: { additive: 0.5 },
      }))
    end
  end

  describe "Research Subsidies" do
    subject { Edict::ResearchSubsidies }

    it "has the correct name" do
      expect(subject.name).to eq("Research Subsidies")
    end

    it "increases the upkeep for Researchers" do
      pop_job = PopJob.new(worker: nil, job: Job::Researcher)

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(ResourceModifier.new({
        energy: { additive: 1 },
      }))
    end
  end

  describe "Thought Enforcement" do
    subject { Edict::ThoughtEnforcement }

    it "has the correct name" do
      expect(subject.name).to eq("Thought Enforcement")
    end

    it "modifies the colony attribute modifiers for telepaths" do
      pop_job = PopJob.new(job: Job::Telepath, worker: nil)

      expect(subject.job_colony_attribute_modifiers(pop_job)).to eq(
        ResourceModifier.new({
          crime: { additive: -5 },
        })
      )
    end
  end

  describe "sacrifice edicts" do
    describe "Harmony Sacrifice Edict" do
      subject { Edict::HarmonySacrificeEdict }

      it "has the correct name" do
        expect(subject.name).to eq("Harmony Sacrifice Edict")
      end

      it "modifies the output for death priests" do
        pop_job = PopJob.new(worker: nil, job: Job::DeathPriest)

        expect(subject.job_output_modifiers(pop_job)).to eq(
          ResourceModifier.new({
            unity: { additive: 3 },
          })
        )
      end
    end

    describe "Togetherness Sacrifice Edict" do
      subject { Edict::TogethernessSacrificeEdict }

      it "has the correct name" do
        expect(subject.name).to eq("Togetherness Sacrifice Edict")
      end

      it "modifies the output for death priests" do
        pop_job = PopJob.new(worker: nil, job: Job::DeathPriest)

        expect(subject.job_output_modifiers(pop_job)).to eq(
          ResourceModifier.new({
            unity: { additive: 3 },
          })
        )
      end
    end

    describe "Bounty Sacrifice Edict" do
      subject { Edict::BountySacrificeEdict }

      it "has the correct name" do
        expect(subject.name).to eq("Bounty Sacrifice Edict")
      end

      it "modifies the output for death priests" do
        pop_job = PopJob.new(worker: nil, job: Job::DeathPriest)

        expect(subject.job_output_modifiers(pop_job)).to eq(
          ResourceModifier.new({
            unity: { additive: 3 },
          })
        )
      end
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

  describe "Capacity Subsidies" do
    let(:empire) do
      Empire.new(
        founder_species: species,
        ruler: ruler,
        edicts: [Edict::CapacitySubsidies],
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

    it "modifies the upkeep of Technicians" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Technician,
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        energy: 0.5,
      }))
    end
  end

  describe "Forge Subsidies" do
    let(:empire) do
      Empire.new(
        founder_species: species,
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
        job: Job::Metallurgist,
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
        job: Job::CatalyticTechnician,
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
        founder_species: species,
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
        job: Job::Artisan,
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
        job: Job::Artificer,
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
        job: Job::PearlDiver,
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        food: 2,
        minerals: 2,
        energy: 1,
      }))
    end
  end

  describe "Mining Subsidies" do
    let(:empire) do
      Empire.new(
        founder_species: species,
        ruler: ruler,
        edicts: [Edict::MiningSubsidies],
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

    it "modifies the upkeep of Miners" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Miner,
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        energy: 0.5,
      }))
    end

    it "modifies the upkeep of Scrap Miners" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::ScrapMiner,
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        energy: 0.5,
      }))
    end
  end

  describe "Research Subsidies" do
    let(:empire) do
      Empire.new(
        founder_species: species,
        ruler: ruler,
        edicts: [Edict::ResearchSubsidies],
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

    it "modifies the upkeep of Researchers" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Researcher,
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
        consumer_goods: 2,
        energy: 1,
      }))
    end
  end

  describe "Thought Enforcement" do
    let(:empire) do
      Empire.new(
        founder_species: species,
        ruler: ruler,
        edicts: [Edict::ThoughtEnforcement],
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

    it "modifies the colony attribute modifiers of Telepaths" do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Telepath,
      )

      expect(pop.job.colony_attribute_modifiers).to eq(
        ResourceModifier.new({
          crime: { additive: -40 },
        })
      )
    end
  end

  describe "sacrifice edicts" do
    describe "Harmony Sacrifice Edict" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          edicts: [Edict::HarmonySacrificeEdict],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the output of Death Priests" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::DeathPriest,
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 6,
          society_research: 1,
        }))
      end
    end

    describe "Togetherness Sacrifice Edict" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          edicts: [Edict::TogethernessSacrificeEdict],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the output of Death Priests" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::DeathPriest,
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 6,
          society_research: 1,
        }))
      end
    end

    describe "Bounty Sacrifice Edict" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          edicts: [Edict::BountySacrificeEdict],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the output of Death Priests" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::DeathPriest,
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 6,
          society_research: 1,
        }))
      end
    end
  end
end
