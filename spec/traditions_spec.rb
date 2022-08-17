require_relative "../stellaris/lib/stellaris"

RSpec.describe "traditions" do
  describe "domination tree" do
    describe "Judgment Corps" do
      subject { Tradition::JudgmentCorps }

      it "has the correct name" do
        expect(subject.name).to eq("Judgment Corps")
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
end

RSpec.describe "end-to-end tests" do
  let(:species) do
    Species.new(
      living_standard: nil,
    )
  end
  let(:ruler) { Leader.new(level: 0) }

  describe "domination tree" do
    describe "Judgment Corps" do
      let(:empire) do
        Empire.new(
          founding_species: species,
          ruler: ruler,
          traditions: [Tradition::JudgmentCorps],
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
end