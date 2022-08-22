# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::CultureWorker do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Culture Worker')
  end

  it 'produces 3 Unity and 3 Society Research' do
    expect(job.output).to eq_resources({ unity: 3, society_research: 3 })
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_culture_worker }
end
