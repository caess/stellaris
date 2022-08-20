# frozen_string_literal: true

require 'job'
require 'pop_job'

RSpec.describe Job::OffspringDrone do
  subject(:job) { described_class }

  let(:expected_menial_drone_modifier) { ResourceModifier.multiplyAllProducedResources(0.1) }

  it 'is named Offspring drone' do
    expect(job.name).to eq('Offspring Drone')
  end

  it 'provides 5 amenities' do
    expect(job.amenities_output).to eq(5)
  end

  it 'provides 2 monthly organic pop assembly points to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(
      { monthly_organic_pop_assembly: { additive: 2 } }
    )
  end

  it 'requires 5 Food' do
    expect(job.upkeep).to eq_resources({ food: 5 })
  end

  it 'increases the resource production of menial drones by 10%' do
    menial_drone_job = instance_double(Job)
    allow(menial_drone_job).to receive(:menial_drone?).and_return(true)

    pop_job = PopJob.new(worker: nil, job: menial_drone_job)

    expect(job.all_job_output_modifiers(pop_job)).to eq(expected_menial_drone_modifier)
  end

  it 'does not increase the resource production of other jobs' do
    not_menial_drone_job = instance_double(Job)
    allow(not_menial_drone_job).to receive(:menial_drone?).and_return(false)

    pop_job = PopJob.new(worker: nil, job: not_menial_drone_job)

    expect(job.all_job_output_modifiers(pop_job)).to be_empty
  end
end
