# frozen_string_literal: true

require 'job'

RSpec.describe Job::Toiler do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Toiler')
  end

  it 'provides 2 amenities' do
    expect(job.amenities_output).to eq(2)
  end

  it { is_expected.to be_slave }
end
