# frozen_string_literal: true

require_relative '../../lib/job'

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
end
