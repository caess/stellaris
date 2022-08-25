# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::EnergyNexus do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Energy Nexus')
  end

  it 'provide 2 Technician jobs' do
    expect(building.max_jobs).to eq({ Job::Technician => 2 })
  end

  it 'adds 2 Energy to technician job output' do
    job = instance_double(Job)
    allow(job).to receive(:technician?).and_return(true)

    technician = PopJob.new(worker: nil, job: job)

    expect(building.job_output_modifiers(technician))
      .to eq_resource_modifier({ energy: { additive: 2 } })
  end

  it 'requires 2 Energy and 1 Exotic Gas' do
    expect(building.upkeep).to eq_resources({ energy: 2, exotic_gases: 1 })
  end
end
