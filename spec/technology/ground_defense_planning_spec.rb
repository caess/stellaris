# frozen_string_literal: true

require 'job'
require 'pop_job'
require 'technology'

RSpec.describe Technology::GroundDefensePlanning do
  subject(:tech) { described_class }

  it 'has the correct name' do
    expect(tech.name).to eq('Ground Defense Planning')
  end

  it 'adds 2 to the naval capacity provided by Necromancers' do
    necromancer = PopJob.new(worker: nil, job: Job::Necromancer)

    expect(tech.job_empire_attribute_modifiers(necromancer))
      .to eq_resource_modifier({ naval_capacity: { additive: 2 } })
  end

  it 'adds 2 to the naval capacity provided by Soldiers' do
    soldier = PopJob.new(worker: nil, job: Job::Soldier)

    expect(tech.job_empire_attribute_modifiers(soldier))
      .to eq_resource_modifier({ naval_capacity: { additive: 2 } })
  end

  it 'adds 2 to the naval capacity provided by Warrior Drones' do
    warrior_drone = PopJob.new(worker: nil, job: Job::WarriorDrone)

    expect(tech.job_empire_attribute_modifiers(warrior_drone))
      .to eq_resource_modifier({ naval_capacity: { additive: 2 } })
  end

  context 'when learned by an empire' do
    include_context 'default empire' do
      let(:technologies) { [described_class] }

      it 'increases the naval capacity provided by Necromancers to 4' do
        necromancer = Pop.new(species: species, colony: colony, job: Job::Necromancer)
        colony.add_pop(necromancer)

        expect(empire.naval_capacity).to eq(24)
      end

      it 'increases the naval capacity provided by Soldiers to 6' do
        soldier = Pop.new(species: species, colony: colony, job: Job::Soldier)
        colony.add_pop(soldier)

        expect(empire.naval_capacity).to eq(26)
      end

      it 'increases the naval capacity provided by Warrior Drones to 6' do
        warrior_drone = Pop.new(species: species, colony: colony, job: Job::WarriorDrone)
        colony.add_pop(warrior_drone)

        expect(empire.naval_capacity).to eq(26)
      end
    end
  end
end
