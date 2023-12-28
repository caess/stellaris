# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::MiningGuilds do
  subject(:civic) { described_class }

  it 'has the correct name' do
    expect(civic.name).to eq('Mining Guilds')
  end

  it 'add 1 Minerals to miner output' do
    job = instance_double(Job)
    allow(job).to receive(:miner?).and_return(true)
    allow(job).to receive(:strategic_resource_miner?).and_return(false)

    miner = PopJob.new(worker: nil, job: job)

    expect(civic.job_output_modifiers(miner)).to eq_resource_modifier({ minerals: { additive: 1 } })
  end

  it 'does not add Minerals to strategic resource miner output' do
    job = instance_double(Job)
    allow(job).to receive(:miner?).and_return(true)
    allow(job).to receive(:strategic_resource_miner?).and_return(true)

    strategic_resource_miner = PopJob.new(worker: nil, job: job)

    expect(civic.job_output_modifiers(strategic_resource_miner)).to be_empty
  end
end
