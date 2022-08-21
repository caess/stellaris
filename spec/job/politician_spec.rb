# frozen_string_literal: true

require 'job'

RSpec.describe Job::Politician do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Politician')
  end

  it 'produces 6 Unity' do
    expect(job.output).to eq_resources({ unity: 6 })
  end

  it 'produces 3 amenities' do
    expect(job.amenities_output).to eq(3)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_ruler }
  it { is_expected.to be_politician }
end