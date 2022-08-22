# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::MoteHarvester do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Mote Harvester')
  end

  it 'produces 2 Volatile Motes' do
    expect(job.output).to eq_resources({ volatile_motes: 2 })
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_miner }
  it { is_expected.to be_strategic_resource_miner }
end
