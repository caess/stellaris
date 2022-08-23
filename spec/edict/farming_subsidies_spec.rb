# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Edict::FarmingSubsidies do
  subject(:edict) { described_class }

  it 'has the correct name' do
    expect(edict.name).to eq('Farming Subsidies')
  end

  it 'adds 0.5 Energy upkeep to Farmers' do
    farmer = PopJob.new(worker: nil, job: Job::Farmer)

    expect(edict.job_upkeep_modifiers(farmer))
      .to eq_resource_modifier({ energy: { additive: 0.5 } })
  end

  it 'adds 0.5 Energy upkeep to Agri-Drones' do
    agri_drone = PopJob.new(worker: nil, job: Job::AgriDrone)

    expect(edict.job_upkeep_modifiers(agri_drone))
      .to eq_resource_modifier({ energy: { additive: 0.5 } })
  end

  context 'when enacted' do
    include_context 'with empire' do
      let(:edicts) { [described_class] }
    end

    let(:farmer) { Pop.new(species: species, colony: colony, job: Job::Farmer) }
    let(:agri_drone) { Pop.new(species: species, colony: colony, job: Job::AgriDrone) }

    it 'adds 0.5 Energy to the upkeep of Farmers' do
      colony.add_pop(farmer)
      expect(farmer.job_upkeep).to eq_resources({ energy: 0.5 })
    end

    it 'adds 0.5 Energy to the upkeep of Agri-Drones' do
      colony.add_pop(agri_drone)
      expect(agri_drone.job_upkeep).to eq_resources({ energy: 0.5 })
    end
  end
end
