# frozen_string_literal: true

require 'job'

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
end
