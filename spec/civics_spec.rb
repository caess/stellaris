require_relative "../stellaris/lib/stellaris"

RSpec.describe 'civics' do
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
end

RSpec.describe 'end-to-end tests' do
  let(:species) do
    Species.new(
      living_standard: nil,
    )
  end
  let(:ruler) { Leader.new(level: 0) }

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
end
