# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/species_trait'

RSpec.describe Job::Technician do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Technician')
  end

  it 'produces 6 Energy' do
    expect(job.output).to eq_resources({ energy: 6 })
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_technician }

  context 'when empire has Capacity Subsidies edict' do
    include_context 'with empire' do
      let(:edicts) { [Edict::CapacitySubsidies] }
    end

    let(:technician) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'requires 0.5 Energy' do
      expect(technician.job_upkeep).to eq_resources({ energy: 0.5 })
    end
  end

  context 'when empire has mechanical founder species' do
    include_context 'with empire' do
      let(:founder_species_traits) { [SpeciesTrait::Mechanical] }
    end

    let(:technician) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 8 Energy' do
      expect(technician.job_output).to eq_resources({ energy: 8 })
    end
  end
end
