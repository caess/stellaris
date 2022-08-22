# frozen_string_literal: true

require_relative '../../lib/colony'
require_relative '../../lib/empire'
require_relative '../../lib/job'
require_relative '../../lib/leader'
require_relative '../../lib/pop'
require_relative '../../lib/pop_job'
require_relative '../../lib/sector'
require_relative '../../lib/species'

RSpec.describe Job::OffspringDrone do
  subject(:job) { described_class }

  let(:expected_menial_drone_modifier) { ResourceModifier::MultiplyAllProducedResources.new(0.1) }

  it 'is named Offspring drone' do
    expect(job.name).to eq('Offspring Drone')
  end

  it 'provides 5 amenities' do
    expect(job.amenities_output).to eq(5)
  end

  it 'provides 2 monthly organic pop assembly points to the colony' do
    expect(job.colony_attribute_modifiers[:monthly_organic_pop_assembly]).to eq({ additive: 2 })
  end

  it 'replaces defense armies on the colony with offspring-led armies' do
    expect(job.colony_attribute_modifiers[:defense_armies]).to eq({ map: :offspring_led_armies })
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

  context 'when assigned to a colony' do
    let(:species) do
      Species.new(
        living_standard: nil
      )
    end
    let(:empire) do
      Empire.new(
        founder_species: species,
        ruler: Leader.new(level: 0)
      )
    end
    let(:sector) { Sector.new(empire: empire) }
    let(:colony) do
      colony = Colony.new(type: nil, size: nil, sector: sector, jobs: {
                            described_class => { species => 1 }
                          })
      allow(colony).to receive(:stability_coefficient_modifier).and_return(ResourceModifier::NONE)
      colony
    end

    it 'increases the output of a Tech-Drone to 6.6 Energy' do
      tech_drone = Pop.new(species: species, colony: colony, job: Job::TechDrone)
      colony.add_pop(tech_drone)

      expect(tech_drone.output[:energy]).to be_within(0.001).of(6.6)
    end

    context 'when defense armies are present' do
      before do
        colony.add_pop(Pop.new(species: species, colony: colony, job: Job::WarriorDrone))
      end

      it 'replaces defense armies with offspring-led armies' do
        expect(colony.offspring_led_armies).to eq(3)
      end

      it 'removes the defense armies' do
        expect(colony.defense_armies).to eq(0)
      end
    end
  end
end
