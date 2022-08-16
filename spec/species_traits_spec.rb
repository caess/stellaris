require_relative "../stellaris/lib/stellaris"

RSpec.describe "species traits" do
  describe "Lithoid" do
    subject { SpeciesTrait::Lithoid }

    it "has the correct name" do
      expect(subject.name).to eq("Lithoid")
    end

    it "modifies the output of Colonist jobs" do
      pop_job = PopJob.new(
        job: Job::Colonist,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(ResourceModifier.new({
        food: { additive: -1 },
        minerals: { additive: 1 },
      }))
    end
  end
end

RSpec.describe "end-to-end tests" do
  describe "Lithoid" do
    let(:species) do
      Species.new(
        living_standard: nil,
        traits: [ SpeciesTrait::Lithoid ],
      )
    end

    it "modifies the output of Colonist jobs" do
      pop = Pop.new(
        species: species,
        colony: nil,
        job: Job::Colonist,
      )

      expect(pop.output).to eq(ResourceGroup.new({minerals: 1}))
    end
  end
end