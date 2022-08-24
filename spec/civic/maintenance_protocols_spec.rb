# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::MaintenanceProtocols do
  subject(:civic) { described_class }

  it 'has the correct name' do
    expect(civic.name).to eq('Maintenance Protocols')
  end

  it 'adds 1 Unity to Maintenance Drone output' do
    maintenance_drone = PopJob.new(worker: nil, job: Job::MaintenanceDrone)

    expect(civic.job_output_modifiers(maintenance_drone))
      .to eq_resource_modifier({ unity: { additive: 1 } })
  end

  context 'when chosen for empire' do
    include_context 'with empire' do
      let(:civics) { [described_class] }
    end

    let(:maintenance_drone) { Pop.new(species: species, colony: colony, job: Job::MaintenanceDrone) }

    it 'adds 1 Unity to the output of Maintenance Drones' do
      expect(maintenance_drone.job_output[:unity]).to eq(1)
    end
  end
end
