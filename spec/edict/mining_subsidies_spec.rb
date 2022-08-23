# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Edict::MiningSubsidies do
  subject(:edict) { described_class }

  it 'has the correct name' do
    expect(edict.name).to eq('Mining Subsidies')
  end

  it 'adds 0.5 Energy upkeep to miners' do
    job = instance_double(Job)
    allow(job).to receive(:miner?).and_return(true)

    miner = PopJob.new(worker: nil, job: job)

    expect(edict.job_upkeep_modifiers(miner))
      .to eq_resource_modifier({ energy: { additive: 0.5 } })
  end

  context 'when enacted' do
    include_context 'with empire' do
      let(:edicts) { [described_class] }
    end

    it 'adds 0.5 Energy to the upkeep of Miners' do
      miner = Pop.new(species: species, colony: colony, job: Job::Miner)
      expect(miner.job_upkeep).to eq_resources({ energy: 0.5 })
    end

    it 'adds 0.5 Energy to the upkeep of Scrap Miners' do
      scrap_miner = Pop.new(species: species, colony: colony, job: Job::ScrapMiner)
      expect(scrap_miner.job_upkeep).to eq_resources({ energy: 0.5 })
    end

    it 'adds 0.5 Energy to the upkeep of Crystal Miners' do
      crystal_miner = Pop.new(species: species, colony: colony, job: Job::CrystalMiner)
      expect(crystal_miner.job_upkeep).to eq_resources({ energy: 0.5 })
    end

    it 'adds 0.5 Energy to the upkeep of Gas Extractors' do
      gas_extractor = Pop.new(species: species, colony: colony, job: Job::GasExtractor)
      expect(gas_extractor.job_upkeep).to eq_resources({ energy: 0.5 })
    end

    it 'adds 0.5 Energy to the upkeep of Mote Harvesters' do
      mote_harvester = Pop.new(species: species, colony: colony, job: Job::MoteHarvester)
      expect(mote_harvester.job_upkeep).to eq_resources({ energy: 0.5 })
    end

    it 'adds 0.5 Energy to the upkeep of Mining Drones' do
      mining_drone = Pop.new(species: species, colony: colony, job: Job::MiningDrone)
      expect(mining_drone.job_upkeep).to eq_resources({ energy: 0.5 })
    end

    it 'adds 0.5 Energy to the upkeep of Scrap Miner Drones' do
      scrap_miner_drone = Pop.new(species: species, colony: colony, job: Job::ScrapMinerDrone)
      expect(scrap_miner_drone.job_upkeep).to eq_resources({ energy: 0.5 })
    end
  end
end
