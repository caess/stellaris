# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/species_trait'

RSpec.describe Job::DeathChronicler do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Death Chronicler')
  end

  it 'produces 2 Unity and 2 Society Research' do
    expect(job.output).to eq_resources({ unity: 2, society_research: 2 })
  end

  it 'produces 2 amenities' do
    expect(job.amenities_output).to eq(2)
  end

  it 'provides 2 stability' do
    expect(job.stability_modifier).to eq(2)
  end

  it 'requires 2 Consumer Goods and 1 Food' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2, food: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_administrator }

  context 'when species is Lithoid' do
    include_context 'with species' do
      let(:traits) { [SpeciesTrait::Lithoid] }
    end

    let(:death_chronicler) { Pop.new(species: species, colony: nil, job: described_class) }

    it 'requires 2 Consumer Goods and 1 Minerals' do
      expect(death_chronicler.job_upkeep).to eq_resources({ consumer_goods: 2, minerals: 1 })
    end
  end

  context 'when empire has Byzantine Bureaucracy civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::ByzantineBureaucracy] }
    end

    let(:death_chronicler) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 3 Unity and 2 Society Research' do
      expect(death_chronicler.job_output).to eq_resources({ unity: 3, society_research: 2 })
    end
  end
end
