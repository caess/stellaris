# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::MineralPurificationHubs do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Mineral Purification Hubs')
  end

  it 'provides 2 Miner jobs' do
    expect(building.max_jobs).to eq({ Job::Miner => 2 })
  end

  it 'adds 2 Minerals to the output of miner jobs' do
    job = instance_double(Job)
    allow(job).to receive(:miner?).and_return(true)
    allow(job).to receive(:strategic_resource_miner?).and_return(false)

    miner = PopJob.new(worker: nil, job: job)

    expect(building.job_output_modifiers(miner)).to eq_resource_modifier({ minerals: { additive: 2 } })
  end

  it 'adds 1 Minerals and 0.5 Alloys to the output of Scrap Miner jobs' do
    scrap_miner = PopJob.new(worker: nil, job: Job::ScrapMiner)

    expect(building.job_output_modifiers(scrap_miner))
      .to eq_resource_modifier({ minerals: { additive: 1 }, alloys: { additive: 0.5 } })
  end

  it 'does not add Minerals to the output of strategic resource miner jobs' do
    job = instance_double(Job)
    allow(job).to receive(:miner?).and_return(true)
    allow(job).to receive(:strategic_resource_miner?).and_return(true)

    strategic_resource_miner = PopJob.new(worker: nil, job: job)

    expect(building.job_output_modifiers(strategic_resource_miner)).to be_empty
  end

  it 'requires 2 Energy and 1 Volatile Mote' do
    expect(building.upkeep).to eq_resources({ energy: 2, volatile_motes: 1 })
  end
end
