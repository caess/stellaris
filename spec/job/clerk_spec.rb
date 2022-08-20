# frozen_string_literal: true

require 'job'

RSpec.describe Job::Clerk do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Clerk')
  end

  it 'produces 4 Trade' do
    expect(job.output).to eq_resources({ trade: 4 })
  end

  it 'produces 2 amenities' do
    expect(job.amenities_output).to eq(2)
  end

  it { is_expected.to be_worker }
end
