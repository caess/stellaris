# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Edict::ForgeSubsidies do
  subject(:edict) { described_class }

  it 'has the correct name' do
    expect(edict.name).to eq('Forge Subsidies')
  end

  it 'adds 1 Energy upkeep to metallurgists' do
    job = instance_double(Job)
    allow(job).to receive(:metallurgist?).and_return(true)
    metallurgist = PopJob.new(worker: nil, job: job)

    expect(edict.job_upkeep_modifiers(metallurgist)).to eq_resource_modifier({ energy: { additive: 1 } })
  end

  context 'when enacted' do
    include_context 'with empire' do
      let(:edicts) { [described_class] }
    end

    let(:metallurgist) { Pop.new(species: species, colony: colony, job: Job::Metallurgist) }
    let(:catalytic_technician) { Pop.new(species: species, colony: colony, job: Job::CatalyticTechnician) }

    it 'adds 1 Energy to the upkeep of Metallurgists' do
      expect(metallurgist.job_upkeep).to eq_resources({ minerals: 6, energy: 1 })
    end

    it 'adds 1 Energy to the upkeep of Catalytic Technicians' do
      expect(catalytic_technician.job_upkeep).to eq_resources({ food: 9, energy: 1 })
    end
  end
end
