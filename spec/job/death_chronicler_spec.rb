# frozen_string_literal: true

require 'job'

RSpec.describe Job::DeathChronicler do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Death Chronicler')
  end

  it 'produces 2 Unity and 2 Society Research' do
    expect(job.output).to eq_resources({ unity: 2, society_research: 2 })
  end

  it 'produces 2 amenities' do
    expect(job.amenities_output).to eq(2)
  end

  it 'provides 2 stability' do
    expect(job.stability_modifier).to eq(2)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_administrator }
end
