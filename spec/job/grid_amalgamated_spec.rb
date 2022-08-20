# frozen_string_literal: true

require 'job'

RSpec.describe Job::GridAmalgamated do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Grid Amalgamated')
  end

  it 'provides 4 Energy' do
    expect(job.output).to eq_resources({ energy: 4 })
  end

  it 'uses 0.5 housing' do
    expect(job.worker_housing_modifier).to eq_resource_modifier(
      { housing: { additive: -0.5 } }
    )
  end

  it { is_expected.to be_slave }
end
