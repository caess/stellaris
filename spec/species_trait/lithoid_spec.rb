# frozen_string_literal: true

require 'job'
require 'pop_job'
require 'species'
require 'species_trait'

RSpec.describe SpeciesTrait::Lithoid do
  subject(:trait) { described_class }

  it 'has the correct name' do
    expect(trait.name).to eq('Lithoid')
  end

  it 'replaces Food in Colonist output with Minerals' do
    colonist = PopJob.new(worker: nil, job: Job::Colonist)

    expect(trait.job_output_modifiers(colonist))
      .to eq_resource_modifier({ food: { additive: -1 }, minerals: { additive: 1 } })
  end

  it 'replaces Food in Reassigner upkeep with Minerals' do
    reassigner = PopJob.new(worker: nil, job: Job::Reassigner)

    expect(trait.job_upkeep_modifiers(reassigner))
      .to eq_resource_modifier({ food: { additive: -2 }, minerals: { additive: 2 } })
  end

  it 'replaces Food in Necrophyte upkeep with Minerals' do
    necrophyte = PopJob.new(worker: nil, job: Job::Necrophyte)

    expect(trait.job_upkeep_modifiers(necrophyte))
      .to eq_resource_modifier({ food: { additive: -1 }, minerals: { additive: 1 } })
  end

  it 'changes the output of Livestock jobs to 2 Minerals' do
    livestock = PopJob.new(worker: nil, job: Job::Livestock)

    expect(trait.job_output_modifiers(livestock))
      .to eq_resource_modifier({ food: { additive: -4 }, minerals: { additive: 2 } })
  end

  it 'replaces the Food in Spawning Drone upkeep with Minerals' do
    spawning_drone = PopJob.new(worker: nil, job: Job::SpawningDrone)

    expect(trait.job_upkeep_modifiers(spawning_drone))
      .to eq_resource_modifier({ food: { additive: -5 }, minerals: { additive: 5 } })
  end

  it 'replaces the Food in Offspring Drone upkeep with Minerals' do
    offspring_drone = PopJob.new(worker: nil, job: Job::OffspringDrone)

    expect(trait.job_upkeep_modifiers(offspring_drone))
      .to eq_resource_modifier({ food: { additive: -5 }, minerals: { additive: 5 } })
  end

  context 'when the species for pops' do
    let(:species) do
      Species.new(
        living_standard: nil,
        traits: [described_class]
      )
    end

    it 'changes the output of Colonist jobs to 1 Minerals' do
      colonist = Pop.new(species: species, colony: nil, job: Job::Colonist)

      expect(colonist.job_output).to eq_resources({ minerals: 1 })
    end

    it 'changes the upkeep of Reassigner jobs to 2 Consumer Goods and 2 Minerals' do
      reassigner = Pop.new(species: species, colony: nil, job: Job::Reassigner)

      expect(reassigner.job_upkeep).to eq_resources({ consumer_goods: 2, minerals: 2 })
    end

    it 'changes the upkeep of Necrophyte jobs to 1 Consumer Good and 1 Minerals' do
      necrophyte = Pop.new(species: species, colony: nil, job: Job::Necrophyte)

      expect(necrophyte.job_upkeep).to eq_resources({ consumer_goods: 1, minerals: 1 })
    end

    it 'changes the output of Livestock jobs to 2 Minerals' do
      livestock = Pop.new(species: species, colony: nil, job: Job::Livestock)

      expect(livestock.job_output).to eq_resources({ minerals: 2 })
    end

    it 'changes the upkeep of Spawning Drone jobs to 5 Minerals' do
      spawning_drone = Pop.new(species: species, colony: nil, job: Job::SpawningDrone)

      expect(spawning_drone.job_upkeep).to eq_resources({ minerals: 5 })
    end

    it 'changes the upkeep of Offspring Drone jobs to 5 Minerals' do
      offspring_drone = Pop.new(species: species, colony: nil, job: Job::OffspringDrone)

      expect(offspring_drone.job_upkeep).to eq_resources({ minerals: 5 })
    end
  end
end
