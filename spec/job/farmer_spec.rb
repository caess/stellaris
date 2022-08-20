# frozen_string_literal: true

require 'job'

RSpec.describe Job::Farmer do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Farmer')
  end

  it 'produces 6 Food' do
    expect(job.output).to eq_resources({ food: 6 })
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_farmer }
end
