# frozen_string_literal: true

require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/species_trait'

RSpec.describe Job::Reassigner do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Reassigner')
  end

  it 'provides 2 monthly organic pop assembly points to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier({ monthly_organic_pop_assembly: { additive: 2 } })
  end

  it 'requires 2 Consumer Goods and 2 Food' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2, food: 2 })
  end

  it { is_expected.to be_specialist }

  context 'when species is Lithoid' do
    include_context 'with species' do
      let(:traits) { [SpeciesTrait::Lithoid] }
    end

    let(:reassigner) { Pop.new(species: species, colony: nil, job: described_class) }

    it 'requires 2 Consumer Goods and 2 Minerals' do
      expect(reassigner.job_upkeep).to eq_resources({ consumer_goods: 2, minerals: 2 })
    end
  end
end
