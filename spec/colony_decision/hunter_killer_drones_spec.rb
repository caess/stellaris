# frozen_string_literal: true

require_relative '../../lib/colony_decision'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe ColonyDecision::HunterKillerDrones do
  subject(:modifier) { described_class }

  it 'has the correct name' do
    expect(modifier.name).to eq('Hunter-Killer Drones')
  end

  it 'increases the stability provided by Warrior Drones by 5' do
    warrior_drone = PopJob.new(worker: nil, job: Job::WarriorDrone)

    expect(modifier.job_stability_modifier(warrior_drone)).to eq(5)
  end

  context 'when present on a colony' do
    include_context 'with empire' do
      let(:colony_modifiers) { [described_class] }
    end

    let(:warrior_drone) { Pop.new(species: species, colony: colony, job: Job::WarriorDrone) }

    it 'increases the stability modifier provided by Warrior Drones to 5' do
      colony.add_pop(warrior_drone)

      expect(warrior_drone.stability_modifier).to eq(5)
    end
  end
end
