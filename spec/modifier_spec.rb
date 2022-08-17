require_relative "../stellaris/lib/stellaris"

RSpec.describe "modifier" do
  describe "default" do
    subject { Modifier.new(name: "name") }

    it "returns its name" do
      expect(subject.name).to eq("name")
    end

    it "has no default job output modifiers" do
      expect(subject.job_output_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has no default job upkeep modifiers" do
      expect(subject.job_upkeep_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has no default job colony attribute modifiers" do
      expect(subject.job_colony_attribute_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has no default job empire attribute modifiers" do
      expect(subject.job_empire_attribute_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has no default job amenities output modifier" do
      expect(subject.job_amenities_output_modifier(nil)).to eq(0)
    end

    it "has no default job stability modifier" do
      expect(subject.job_stability_modifier(nil)).to eq(0)
    end

    it "has no default founding species job output modifiers" do
      expect(subject.founder_species_job_output_modifiers(nil)).to eq(
        ResourceModifier::NONE
      )
    end
  end
end
