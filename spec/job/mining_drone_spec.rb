# frozen_string_literal: true

require 'job'

RSpec.describe Job::MiningDrone do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Mining Drone')
  end

  it 'provides 4 Minerals' do
    expect(job.output).to eq_resources({ minerals: 4 })
  end

  it { is_expected.to be_menial_drone }
  it { is_expected.to be_miner }
end
