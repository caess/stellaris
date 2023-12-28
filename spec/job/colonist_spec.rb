# frozen_string_literal: true

require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/species_trait'

RSpec.describe Job::Colonist do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Colonist')
  end

  it 'produces 1 Food' do
    expect(job.output).to eq_resources({ food: 1 })
  end

  it 'produces 3 amenities' do
    expect(job.amenities_output).to eq(3)
  end

  it 'provides 1 defense army to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(
      { defense_armies: { additive: 1 } }
    )
  end

  it { is_expected.to be_specialist }

  context 'when species is Lithoid' do
    include_context 'with species' do
      let(:traits) { [SpeciesTrait::Lithoid] }
    end

    it 'produces 1 Minerals' do
      pop = Pop.new(species: species, colony: nil, job: described_class)

      expect(pop.job_output).to eq_resources({ minerals: 1 })
    end
  end
end
