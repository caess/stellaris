# frozen_string_literal: true

require_relative '../../lib/government'
require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/species_trait'

RSpec.describe Job::Necrophyte do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Necrophyte')
  end

  it 'produces 1.5 Unity' do
    expect(job.output).to eq_resources({ unity: 1.5 })
  end

  it 'produces 5 amenities' do
    expect(job.amenities_output).to eq(5)
  end

  it 'requires 1 Consumer Good and 1 Food' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 1, food: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_pop_assembler }
  it { is_expected.to be_necro_apprentice }

  context 'when species is Lithoid' do
    include_context 'with species' do
      let(:traits) { [SpeciesTrait::Lithoid] }
    end

    let(:necrophyte) { Pop.new(species: species, colony: nil, job: described_class) }

    it 'requires 1 Consumer Good and 1 Minerals' do
      expect(necrophyte.job_upkeep).to eq_resources({ consumer_goods: 1, minerals: 1 })
    end
  end

  context 'when empire is hive mind' do
    include_context 'with empire' do
      let(:government) { Government::HiveMind; }
    end

    let(:necrophyte) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'requires 2 Food' do
      expect(necrophyte.job_upkeep).to eq_resources({ food: 2 })
    end

    context 'when species is Lithoid' do
      include_context 'with empire' do
        let(:species_traits) { [SpeciesTrait::Lithoid] }
        let(:government) { Government::HiveMind }
      end

      let(:necrophyte) { Pop.new(species: species, colony: colony, job: described_class) }

      it 'requires 2 Minerals' do
        expect(necrophyte.job_upkeep).to eq_resources({ minerals: 2 })
      end
    end
  end
end
