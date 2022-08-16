require_relative "../stellaris/lib/stellaris"

RSpec.describe 'modifier' do
  describe "default" do
    subject { Modifier.new(name: 'name') }

    it "returns its name" do
      expect(subject.name).to eq('name')
    end

    it "has no default job output modifiers" do
      expect(subject.job_output_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has no default job upkeep modifiers" do
      expect(subject.job_upkeep_modifiers(nil)).to eq(ResourceModifier::NONE)
    end
  end
end