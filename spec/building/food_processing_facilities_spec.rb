# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::FoodProcessingFacilities do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Food Processing Facilities')
  end

  it 'provides 1 Farmer job' do
    expect(building.max_jobs).to eq({ Job::Farmer => 1 })
  end

  it 'adds 1 Food to the output of farmer jobs' do
    job = instance_double(Job)
    allow(job).to receive(:farmer?).and_return(true)

    farmer = PopJob.new(worker: nil, job: job)

    expect(building.job_output_modifiers(farmer)).to eq_resource_modifier({ food: { additive: 1 } })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
