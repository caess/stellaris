# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::PearlDiver do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Pearl Diver')
  end

  it 'produces 3 Consumer Goods and 3 Trade' do
    expect(job.output).to eq_resources({ consumer_goods: 3, trade: 3 })
  end

  it 'requires 2 Food and 2 Minerals' do
    expect(job.upkeep).to eq_resources({ food: 2, minerals: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_artisan }
end
