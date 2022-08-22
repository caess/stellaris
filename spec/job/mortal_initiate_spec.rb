# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::MortalInitiate do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Mortal Initiate')
  end

  it 'produces 2 Unity and 1 Society Research' do
    expect(job.output).to eq_resources({ unity: 2, society_research: 1 })
  end

  it 'produces 2 amenities' do
    expect(job.amenities_output).to eq(2)
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_administrator }
end
