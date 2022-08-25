# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::MineralPurificationPlants do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Mineral Purification Plants')
  end

  it 'provides 1 Miner job' do
    expect(building.max_jobs).to eq({ Job::Miner => 1 })
  end

  it 'adds 1 Minerals to the output of miner jobs' do
    job = instance_double(Job)
    allow(job).to receive(:miner?).and_return(true)
    allow(job).to receive(:strategic_resource_miner?).and_return(false)

    miner = PopJob.new(worker: nil, job: job)

    expect(building.job_output_modifiers(miner)).to eq_resource_modifier({ minerals: { additive: 1 } })
  end

  it 'does not add Minerals to the output of strategic resource miner jobs' do
    job = instance_double(Job)
    allow(job).to receive(:miner?).and_return(true)
    allow(job).to receive(:strategic_resource_miner?).and_return(true)

    strategic_resource_miner = PopJob.new(worker: nil, job: job)

    expect(building.job_output_modifiers(strategic_resource_miner)).to be_empty
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
