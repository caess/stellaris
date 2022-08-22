# frozen_string_literal: true

require_relative '../../lib/government'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Government::MachineIntelligence do
  subject(:government) { described_class }

  it 'has the correct name' do
    expect(government.name).to eq('Machine Intelligence')
  end

  it 'reduces the Agri-Drone job output by 1 Food' do
    agri_drone = PopJob.new(worker: nil, job: Job::AgriDrone)

    expect(government.job_output_modifiers(agri_drone))
      .to eq_resource_modifier({ food: { additive: -1 } })
  end

  it 'increases the Tech-Drone job output by 2 Energy' do
    tech_drone = PopJob.new(worker: nil, job: Job::TechDrone)

    expect(government.job_output_modifiers(tech_drone))
      .to eq_resource_modifier({ energy: { additive: 2 } })
  end

  context 'when empire government' do
    include_context 'with empire' do
      let(:government) { described_class }
    end

    it 'decreases the output of Agri-Drones to 5 Food' do
      agri_drone = Pop.new(species: species, colony: colony, job: Job::AgriDrone)

      expect(agri_drone.job_output).to eq_resources({ food: 5 })
    end

    it 'increases the output of Tech-Drones to 8 Energy' do
      tech_drone = Pop.new(species: species, colony: colony, job: Job::TechDrone)

      expect(tech_drone.job_output).to eq_resources({ energy: 8 })
    end
  end
end
