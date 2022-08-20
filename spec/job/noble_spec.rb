# frozen_string_literal: true

require 'job'

RSpec.describe Job::Noble do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Noble')
  end

  it 'produces 6 Unity' do
    expect(job.output).to eq_resources({ unity: 6 })
  end

  it 'produces 3 amenities' do
    expect(job.amenities_output).to eq(3)
  end

  it 'provides 2 stability' do
    expect(job.stability_modifier).to eq(2)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_ruler }
  it { is_expected.to be_politician }
  it { is_expected.to be_noble }
end
