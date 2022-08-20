# frozen_string_literal: true

require 'job'

RSpec.describe Job::Entertainer do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Entertainer')
  end

  it 'produces 1 Unity' do
    expect(job.output).to eq_resources({ unity: 1 })
  end

  it 'produces 10 amenities' do
    expect(job.amenities_output).to eq(10)
  end

  it 'requires 1 Consumer Good' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_entertainer }
end
