# frozen_string_literal: true

require 'modifier'

RSpec.describe Modifier do
  describe 'default' do
    subject(:modifier) { described_class.new(name: 'name') }

    it 'returns its name' do
      expect(modifier.name).to eq('name')
    end

    it 'has no default job output modifiers' do
      expect(modifier.job_output_modifiers(nil)).to be_empty
    end

    it 'has no default job upkeep modifiers' do
      expect(modifier.job_upkeep_modifiers(nil)).to be_empty
    end

    it 'has no default job colony attribute modifiers' do
      expect(modifier.job_colony_attribute_modifiers(nil)).to be_empty
    end

    it 'has no default job empire attribute modifiers' do
      expect(modifier.job_empire_attribute_modifiers(nil)).to be_empty
    end

    it 'has no default job amenities output modifier' do
      expect(modifier.job_amenities_output_modifier(nil)).to eq(0)
    end

    it 'has no default job stability modifier' do
      expect(modifier.job_stability_modifier(nil)).to eq(0)
    end

    it 'has no default job worker housing modifier' do
      expect(modifier.job_worker_housing_modifier(nil)).to be_empty
    end

    it 'has no default founding species job output modifiers' do
      expect(modifier.founder_species_job_output_modifiers(nil)).to be_empty
    end
  end
end
