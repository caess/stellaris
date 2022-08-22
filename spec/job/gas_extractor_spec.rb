# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::GasExtractor do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Gas Extractor')
  end

  it 'produces 2 Exotic Gases' do
    expect(job.output).to eq_resources({ exotic_gases: 2 })
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_miner }
  it { is_expected.to be_strategic_resource_miner }
end
