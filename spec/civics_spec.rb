require_relative "../stellaris/lib/stellaris"

RSpec.describe 'civics' do
  context "standard civics" do
    describe 'Byzantine Bureaucracy' do
      subject { Civic::ByzantineBureaucracy }

      it "has the correct name" do
        expect(subject.name).to eq("Byzantine Bureaucracy")
      end

      it "adds unity to Bureaucrat output" do
        pop_job = PopJob.new(worker: nil, job: Job::Bureaucrat)

        expect(subject.job_output_modifiers(pop_job)).to eq(
          ResourceModifier.new({
            unity: { additive: 1 },
          })
        )
      end

      it "adds unity to Death Chronicler output" do
        pop_job = PopJob.new(worker: nil, job: Job::DeathChronicler)

        expect(subject.job_output_modifiers(pop_job)).to eq(
          ResourceModifier.new({
            unity: { additive: 1 },
          })
        )
      end

      it "adds stability to Bureaucrats" do
        pop_job = PopJob.new(worker: nil, job: Job::Bureaucrat)

        expect(subject.job_stability_modifier(pop_job)).to eq(1)
      end
    end

    describe "Exalted Priesthood" do
      subject { Civic::ExaltedPriesthood }

      it "has the correct name" do
        expect(subject.name).to eq("Exalted Priesthood")
      end

      it "adds unity to priest output" do
        job = instance_double("Job")

        expect(job).to receive(:priest?).and_return(true)

        pop_job = PopJob.new(
          worker: nil,
          job: job,
        )

        expect(subject.job_output_modifiers(pop_job)).to eq(ResourceModifier.new({
          unity: { additive: 1 },
        }))
      end
    end

    describe "Mining Guilds" do
      subject { Civic::MiningGuilds }

      it "has the correct name" do
        expect(subject.name).to eq("Mining Guilds")
      end

      it "add minerals to miner output" do
        job = instance_double("Job")

        expect(job).to receive(:miner?).and_return(true)
        expect(job).to receive(:strategic_resource_miner?).and_return(false)

        pop_job = PopJob.new(worker: nil, job: job)

        expect(subject.job_output_modifiers(pop_job)).to eq(
          ResourceModifier.new({minerals: { additive: 1 }})
        )
      end

      it "does not add minerals to strategic resource miner output" do
        job = instance_double("Job")

        expect(job).to receive(:miner?).and_return(true)
        expect(job).to receive(:strategic_resource_miner?).and_return(true)

        pop_job = PopJob.new(worker: nil, job: job)

        expect(subject.job_output_modifiers(pop_job)).to eq(
          ResourceModifier::NONE
        )
      end
    end

    describe "Pleasure Seekers" do
      subject { Civic::PleasureSeekers }

      it "has the correct name" do
        expect(subject.name).to eq("Pleasure Seekers")
      end
    end

    describe "Police State" do
      subject { Civic::PoliceState }

      it "has the correct name" do
        expect(subject.name).to eq("Police State")
      end

      it "adds unity to Enforcer output" do
        pop_job = PopJob.new(
          worker: nil,
          job: Job::Enforcer,
        )

        expect(subject.job_output_modifiers(pop_job)).to eq(ResourceModifier.new({
          unity: { additive: 1 },
        }))
      end

      it "adds unity to Telepath output" do
        pop_job = PopJob.new(
          worker: nil,
          job: Job::Telepath,
        )

        expect(subject.job_output_modifiers(pop_job)).to eq(ResourceModifier.new({
          unity: { additive: 1 },
        }))
      end
    end
  end

  context "corporate civics" do
    describe "Corporate Hedonism" do
      subject { Civic::CorporateHedonism }

      it "has the correct name" do
        expect(subject.name).to eq("Corporate Hedonism")
      end
    end
  end
end

RSpec.describe 'end-to-end tests' do
  let(:species) do
    Species.new(
      living_standard: nil,
    )
  end
  let(:ruler) { Leader.new(level: 0) }

  context "standard civics" do
    describe "Byzantine Bureaucracy" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          civics: [Civic::ByzantineBureaucracy],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the output of Bureaucrats" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Bureaucrat,
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 5,
        }))
      end

      it "modifies the stability modifier of Bureaucrats" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Bureaucrat,
        )

        expect(pop.job.stability_modifier).to eq(1)
      end

      it "modifies the output of Death Chroniclers" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::DeathChronicler,
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 3,
          society_research: 2,
        }))
      end
    end

    describe "Exalted Priesthood" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          civics: [Civic::ExaltedPriesthood],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the output of High Priests" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::HighPriest
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 7,
        }))
      end

      it "modifies the output of Priests" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Priest
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 5,
        }))
      end

      it "modifies the output of Death Priests" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::DeathPriest
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 4,
          society_research: 1,
        }))
      end
    end

    describe "Mining Guilds" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          civics: [Civic::MiningGuilds],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the output of Miners" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Miner
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          minerals: 5,
        }))
      end

      it "modifies the output of Scrap Miners" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::ScrapMiner
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          minerals: 3,
          alloys: 1,
        }))
      end
    end

    describe "Pleasure Seekers" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          civics: [Civic::PleasureSeekers],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the colony attribute modifiers of Entertainers" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Entertainer
        )

        expect(pop.job.colony_attribute_modifiers).to eq(ResourceModifier.new({
          pop_growth_speed_percent: { additive: 1 },
        }))
      end
    end

    describe "Police State" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          civics: [Civic::PoliceState],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the output of Enforcers" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Enforcer
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 1,
        }))
      end

      it "modifies the output of Telepaths" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Telepath
        )

        expect(pop.job.output).to eq(ResourceGroup.new({
          unity: 7,
        }))
      end
    end
  end

  context "corporate civics" do
    describe "Corporate Hedonism" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          civics: [Civic::CorporateHedonism],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the colony attribute modifiers of Entertainers" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Entertainer
        )

        expect(pop.job.colony_attribute_modifiers).to eq(ResourceModifier.new({
          pop_growth_speed_percent: { additive: 1 },
        }))
      end
    end
  end
end
