# frozen_string_literal: true

require 'job'

RSpec.describe Job::Angler do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Angler')
  end

  it 'produces 8 Food and 2 Trade' do
    expect(job.output).to eq_resources({ food: 8, trade: 2 })
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_farmer }
end
