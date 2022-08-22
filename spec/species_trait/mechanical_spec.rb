# frozen_string_literal: true

require_relative '../../lib/job'
require_relative '../../lib/pop_job'
require_relative '../../lib/species'
require_relative '../../lib/species_trait'

RSpec.describe SpeciesTrait::Mechanical do
  subject(:trait) { described_class }

  it 'has the correct name' do
    expect(trait.name).to eq('Mechanical')
  end

  it 'removes the worker housing modifier for Servants' do
    servant = PopJob.new(worker: nil, job: Job::Servant)

    expect(trait.job_worker_housing_modifier(servant))
      .to eq_resource_modifier({ housing: { additive: 0.5 } })
  end

  context 'when the founder species' do
    it 'adds 2 Energy to Technician job output' do
      technician = PopJob.new(worker: nil, job: Job::Technician)

      expect(trait.founder_species_job_output_modifiers(technician))
        .to eq_resource_modifier({ energy: { additive: 2 } })
    end

    it 'removes 1 Good from Farmer job output' do
      farmer = PopJob.new(worker: nil, job: Job::Farmer)

      expect(trait.founder_species_job_output_modifiers(farmer))
        .to eq_resource_modifier({ food: { additive: -1 } })
    end
  end

  context 'when the species for pops' do
    let(:species) do
      Species.new(
        living_standard: nil,
        traits: [described_class]
      )
    end

    it 'removes the worker housing modifier of Servant jobs' do
      servant = Pop.new(species: species, colony: nil, job: Job::Servant)

      expect(servant.job.worker_housing_modifier).to eq_resource_modifier({ housing: { additive: 0 } })
    end

    context 'when the founding species for an empire' do
      include_context 'with empire' do
        let(:species_traits) { [described_class] }
      end

      it 'increases the output of Technician jobs to 8 Energy' do
        technician = Pop.new(species: species, colony: colony, job: Job::Technician)

        expect(technician.job_output).to eq_resources({ energy: 8 })
      end

      it 'reduces the output of Farmer jobs to 5 Food' do
        farmer = Pop.new(species: species, colony: colony, job: Job::Farmer)

        expect(farmer.job_output).to eq_resources({ food: 5 })
      end
    end
  end
end
