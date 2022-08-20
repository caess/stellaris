# frozen_string_literal: true

require 'stellaris'

RSpec.describe Job::Livestock do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Livestock')
  end

  it 'provides 4 Food' do
    expect(job.output).to eq_resources({ food: 4 })
  end

  it 'uses only 0.5 housing' do
    expect(job.worker_housing_modifier).to eq_resource_modifier(
      { housing: { additive: -0.5 } }
    )
  end

  it 'has 10% less political power' do
    expect(job.worker_political_power_modifier).to eq_resource_modifier(
      { political_power: { additive: -0.1 } }
    )
  end

  it { is_expected.to be_slave }
end
