# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::FoodProcessingCenters do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Food Processing Centers')
  end

  it 'provides 2 Farmer jobs' do
    expect(building.max_jobs).to eq({ Job::Farmer => 2 })
  end

  it 'adds 2 Food to the output of farmer jobs' do
    job = instance_double(Job)
    allow(job).to receive(:farmer?).and_return(true)

    farmer = PopJob.new(worker: nil, job: job)

    expect(building.job_output_modifiers(farmer)).to eq_resource_modifier({ food: { additive: 2 } })
  end

  it 'requires 2 Energy and 1 Volatile Mote' do
    expect(building.upkeep).to eq_resources({ energy: 2, volatile_motes: 1 })
  end
end
