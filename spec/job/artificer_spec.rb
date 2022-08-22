# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::Artificer do
  subject(:job) { described_class }

  let(:expected_output) do
    {
      consumer_goods: 7,
      trade: 2,
      engineering_research: 1.1
    }
  end

  it 'has the correct name' do
    expect(job.name).to eq('Artificer')
  end

  it 'produces 7 Consumer Goods, 2 Trade, and 1.1 Engineering Research' do
    expect(job.output).to eq_resources(expected_output)
  end

  it 'requires 6 Minerals' do
    expect(job.upkeep).to eq_resources({ minerals: 6 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_artisan }
end
