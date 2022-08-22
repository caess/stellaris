# frozen_string_literal: true

require 'job'
require 'pop_job'
require 'species_trait'

RSpec.describe SpeciesTrait::Machine do
  subject(:trait) { described_class }

  it 'has the correct name' do
    expect(trait.name).to eq('Machine')
  end

  it 'removes the reduced worker housing modifier for Servants' do
    servant = PopJob.new(worker: nil, job: Job::Servant)

    expect(trait.job_worker_housing_modifier(servant))
      .to eq_resource_modifier({ housing: { additive: 0.5 } })
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
  end
end
