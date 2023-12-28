# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop'

RSpec.describe Job::ScrapMiner do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Scrap Miner')
  end

  it 'produces 2 Minerals and 1 Alloy' do
    expect(job.output).to eq_resources({ minerals: 2, alloys: 1 })
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_miner }

  context 'when empire has Mining Guilds civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::MiningGuilds] }
    end

    let(:scrap_miner) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 3 Minerals and 1 Alloy' do
      expect(scrap_miner.job_output).to eq_resources({ minerals: 3, alloys: 1 })
    end
  end

  context 'when empire has Mining Subsidies edict' do
    include_context 'with empire' do
      let(:edicts) { [Edict::MiningSubsidies] }
    end

    let(:scrap_miner) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'requires 0.5 energy' do
      expect(scrap_miner.job_upkeep).to eq_resources({ energy: 0.5 })
    end
  end
end
