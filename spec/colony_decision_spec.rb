# frozen_string_literal: true

require_relative '../lib/colony'
require_relative '../lib/colony_decision'
require_relative '../lib/empire'
require_relative '../lib/job'
require_relative '../lib/leader'
require_relative '../lib/pop'
require_relative '../lib/pop_job'
require_relative '../lib/resource_modifier'
require_relative '../lib/species'

RSpec.describe 'colony decisions' do
  describe 'Anti-Crime Campaign' do
    subject { ColonyDecision::AntiCrimeCampaign }

    it 'has the correct name' do
      expect(subject.name).to eq('Anti-Crime Campaign')
    end

    it 'modifies the upkeep for enforcers' do
      pop_job = PopJob.new(
        worker: nil,
        job: Job::Enforcer
      )

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(ResourceModifier.new({
                                                                                 energy: { additive: 2 }
                                                                               }))
    end

    it 'modifies the colony attribute modifiers for enforcers' do
      pop_job = PopJob.new(
        worker: nil,
        job: Job::Enforcer
      )

      expect(subject.job_colony_attribute_modifiers(pop_job)).to eq(ResourceModifier.new({
                                                                                           crime: { additive: -10 }
                                                                                         }))
    end

    it 'modifies the upkeep for telepaths' do
      pop_job = PopJob.new(
        worker: nil,
        job: Job::Telepath
      )

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(ResourceModifier.new({
                                                                                 energy: { additive: 2 }
                                                                               }))
    end

    it 'modifies the colony attribute modifiers for telepaths' do
      pop_job = PopJob.new(
        worker: nil,
        job: Job::Telepath
      )

      expect(subject.job_colony_attribute_modifiers(pop_job)).to eq(ResourceModifier.new({
                                                                                           crime: { additive: -10 }
                                                                                         }))
    end

    it 'modifies the upkeep for Overseers' do
      pop_job = PopJob.new(
        worker: nil,
        job: Job::Overseer
      )

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(ResourceModifier.new({
                                                                                 energy: { additive: 2 }
                                                                               }))
    end
  end

  describe 'Compliance Protocols' do
    subject { ColonyDecision::ComplianceProtocols }

    it 'has the correct name' do
      expect(subject.name).to eq('Compliance Protocols')
    end

    it 'modifies the stability for Warrior Drones' do
      pop_job = PopJob.new(worker: nil, job: Job::WarriorDrone)

      expect(subject.job_stability_modifier(pop_job)).to eq(5)
    end
  end

  describe 'Hunter-Killer Drones' do
    subject { ColonyDecision::HunterKillerDrones }

    it 'has the correct name' do
      expect(subject.name).to eq('Hunter-Killer Drones')
    end

    it 'modifies the stability for Warrior Drones' do
      pop_job = PopJob.new(worker: nil, job: Job::WarriorDrone)

      expect(subject.job_stability_modifier(pop_job)).to eq(5)
    end
  end

  describe 'Martial Law' do
    subject { ColonyDecision::MartialLaw }

    it 'has the correct name' do
      expect(subject.name).to eq('Martial Law')
    end

    it 'modifies the colony attribute modifiers for necromancers' do
      pop_job = PopJob.new(
        worker: nil,
        job: Job::Necromancer
      )

      expect(subject.job_colony_attribute_modifiers(pop_job)).to eq(ResourceModifier.new({
                                                                                           defense_armies: { additive: 2 }
                                                                                         }))
    end

    it 'modifies the stability for Soldiers' do
      pop_job = PopJob.new(worker: nil, job: Job::Soldier)

      expect(subject.job_stability_modifier(pop_job)).to eq(5)
    end
  end
end

RSpec.describe 'end-to-end tests' do
  let(:species) do
    Species.new(
      living_standard: nil
    )
  end
  let(:ruler) { Leader.new(level: 0) }
  let(:empire) do
    Empire.new(
      founder_species: species,
      ruler: ruler
    )
  end
  let(:sector) { Sector.new(empire: empire) }

  describe 'Anti-Crime Campaign' do
    let(:colony) do
      Colony.new(
        type: nil,
        size: nil,
        sector: sector,
        decisions: [ColonyDecision::AntiCrimeCampaign]
      )
    end

    it 'modifies the colony attribute modifiers of enforcers' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Enforcer
      )

      expect(pop.job.colony_attribute_modifiers).to eq(ResourceModifier.new({
                                                                              crime: { additive: -35 },
                                                                              defense_armies: { additive: 2 }
                                                                            }))
    end

    it 'modifies the upkeep of enforcers' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Enforcer
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
                                                       energy: 2
                                                     }))
    end

    it 'modifies the colony attribute modifiers of telepaths' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Telepath
      )

      expect(pop.job.colony_attribute_modifiers).to eq(ResourceModifier.new({
                                                                              crime: { additive: -45 }
                                                                            }))
    end

    it 'modifies the upkeep of telepaths' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Telepath
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
                                                       energy: 3
                                                     }))
    end

    it 'modifies the upkeep of Overseers' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Overseer
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
                                                       energy: 2
                                                     }))
    end
  end

  describe 'Compliance Protocols' do
    let(:colony) do
      Colony.new(
        type: nil,
        size: nil,
        sector: sector,
        decisions: [ColonyDecision::ComplianceProtocols]
      )
    end

    it 'modifies the stability modifier of Warrior Drones' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::WarriorDrone
      )

      expect(pop.job.stability_modifier).to eq(5)
    end
  end

  describe 'Hunter-Killer Drones' do
    let(:colony) do
      Colony.new(
        type: nil,
        size: nil,
        sector: sector,
        decisions: [ColonyDecision::HunterKillerDrones]
      )
    end

    it 'modifies the stability modifier of Warrior Drones' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::WarriorDrone
      )

      expect(pop.job.stability_modifier).to eq(5)
    end
  end

  describe 'Martial Law' do
    let(:colony) do
      Colony.new(
        type: nil,
        size: nil,
        sector: sector,
        decisions: [ColonyDecision::MartialLaw]
      )
    end

    it 'modifies the colony attribute modifiers of Necromancers' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Necromancer
      )

      expect(pop.job.colony_attribute_modifiers).to eq(ResourceModifier.new({
                                                                              defense_armies: { additive: 5 }
                                                                            }))
    end

    it 'modifies the stability modifier of Soldiers' do
      pop = Pop.new(
        species: species,
        colony: colony,
        job: Job::Soldier
      )

      expect(pop.job.stability_modifier).to eq(5)
    end
  end
end
