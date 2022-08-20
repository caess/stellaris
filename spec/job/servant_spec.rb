# frozen_string_literal: true

require 'job'

RSpec.describe Job::Servant do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Servant')
  end

  it 'provides 4 amenities' do
    expect(job.amenities_output).to eq(4)
  end

  it 'uses only 0.5 housing' do
    expect(job.worker_housing_modifier).to eq_resource_modifier(
      { housing: { additive: -0.5 } }
    )
  end

  it { is_expected.to be_slave }
end
