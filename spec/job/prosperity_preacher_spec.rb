# frozen_string_literal: true

require 'job'

RSpec.describe Job::ProsperityPreacher do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Prosperity Preacher')
  end

  it 'produces 1 Unity and 4 Trade' do
    expect(job.output).to eq_resources({ unity: 1, trade: 4 })
  end

  it 'produces 3 amenities' do
    expect(job.amenities_output).to eq(3)
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_administrator }
  it { is_expected.to be_priest }
end
