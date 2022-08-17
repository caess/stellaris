require_relative "../stellaris/lib/stellaris"

RSpec.describe 'civics' do
  context "standard civics" do
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
    describe "Exalted Priesthood" do
      let(:empire) do
        Empire.new(
          founding_species: species,
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
    end

    describe "Pleasure Seekers" do
      let(:empire) do
        Empire.new(
          founding_species: species,
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
          founding_species: species,
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
          founding_species: species,
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
