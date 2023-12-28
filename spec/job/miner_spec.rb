# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop'

RSpec.describe Job::Miner do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Miner')
  end

  it 'produces 4 Minerals' do
    expect(job.output).to eq_resources({ minerals: 4 })
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_miner }

  context 'when empire has Mining Guilds civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::MiningGuilds] }
    end

    let(:miner) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 5 Minerals' do
      expect(miner.job_output).to eq_resources({ minerals: 5 })
    end
  end

  context 'when empire has Mining Subsidies edict' do
    include_context 'with empire' do
      let(:edicts) { [Edict::MiningSubsidies] }
    end

    let(:miner) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'requires 0.5 energy' do
      expect(miner.job_upkeep).to eq_resources({ energy: 0.5 })
    end
  end
end
