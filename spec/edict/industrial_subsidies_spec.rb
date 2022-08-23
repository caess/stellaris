# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Edict::IndustrialSubsidies do
  subject(:edict) { described_class }

  it 'has the correct name' do
    expect(edict.name).to eq('Industrial Subsidies')
  end

  it 'adds 1 Energy upkeep to artisans' do
    job = instance_double(Job)
    allow(job).to receive(:artisan?).and_return(true)

    artisan = PopJob.new(worker: nil, job: job)

    expect(edict.job_upkeep_modifiers(artisan))
      .to eq_resource_modifier({ energy: { additive: 1 } })
  end

  context 'when enacted' do
    include_context 'with empire' do
      let(:edicts) { [described_class] }
    end

    let(:artisan) { Pop.new(species: species, colony: colony, job: Job::Artisan) }
    let(:artificer) { Pop.new(species: species, colony: colony, job: Job::Artificer) }
    let(:pearl_diver) { Pop.new(species: species, colony: colony, job: Job::PearlDiver) }

    it 'adds 1 Energy to the upkeep of Artisans' do
      expect(artisan.job_upkeep).to eq_resources({ minerals: 6, energy: 1 })
    end

    it 'adds 1 Energy to the upkeep of Artificers' do
      expect(artificer.job_upkeep).to eq_resources({ minerals: 6, energy: 1 })
    end

    it 'adds 1 Energy to the upkeep of Pearl Divers' do
      expect(pearl_diver.job_upkeep).to eq_resources({ food: 2, minerals: 2, energy: 1 })
    end
  end
end
