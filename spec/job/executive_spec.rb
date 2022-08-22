# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::Executive do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Executive')
  end

  it 'produces 6 Unity and 4 Trade' do
    expect(job.output).to eq_resources({ unity: 6, trade: 4 })
  end

  it 'produces 3 amenities' do
    expect(job.amenities_output).to eq(3)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_ruler }
  it { is_expected.to be_politician }
  it { is_expected.to be_executive }
end
