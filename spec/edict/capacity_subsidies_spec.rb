# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Edict::CapacitySubsidies do
  subject(:edict) { described_class }

  it 'has the correct name' do
    expect(edict.name).to eq('Capacity Subsidies')
  end

  it 'adds 0.5 Energy upkeep to Technicians' do
    technician = PopJob.new(worker: nil, job: Job::Technician)

    expect(edict.job_upkeep_modifiers(technician))
      .to eq_resource_modifier({ energy: { additive: 0.5 } })
  end

  it 'adds 0.5 Energy upkeep to Tech-Drones' do
    tech_drone = PopJob.new(worker: nil, job: Job::TechDrone)

    expect(edict.job_upkeep_modifiers(tech_drone))
      .to eq_resource_modifier({ energy: { additive: 0.5 } })
  end

  context 'when enacted' do
    include_context 'with empire' do
      let(:edicts) { [described_class] }
    end

    let(:technician) { Pop.new(species: species, colony: colony, job: Job::Technician) }
    let(:tech_drone) { Pop.new(species: species, colony: colony, job: Job::TechDrone) }

    it 'adds 0.5 Energy to the upkeep of Technicians' do
      colony.add_pop(technician)
      expect(technician.job_upkeep).to eq_resources({ energy: 0.5 })
    end

    it 'adds 0.5 Energy to the upkeep of Tech-Drones' do
      colony.add_pop(tech_drone)
      expect(tech_drone.job_upkeep).to eq_resources({ energy: 0.5 })
    end
  end
end
