# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::ExaltedPriesthood do
  subject(:civic) { described_class }

  it 'has the correct name' do
    expect(civic.name).to eq('Exalted Priesthood')
  end

  it 'adds 1 Unity to priest output' do
    job = instance_double(Job)
    allow(job).to receive(:priest?).and_return(true)

    priest = PopJob.new(worker: nil, job: job)

    expect(civic.job_output_modifiers(priest)).to eq_resource_modifier({ unity: { additive: 1 } })
  end

  context 'when chosen for empire' do
    include_context 'with empire' do
      let(:civics) { [described_class] }
    end

    let(:high_priest) { Pop.new(species: species, colony: colony, job: Job::HighPriest) }
    let(:priest) { Pop.new(species: species, colony: colony, job: Job::Priest) }
    let(:death_priest) { Pop.new(species: species, colony: colony, job: Job::DeathPriest) }

    it 'increases the Unity output of High Priests to 7' do
      colony.add_pop(high_priest)

      expect(high_priest.job_output[:unity]).to eq(7)
    end

    it 'increases the Unity output of Priests to 5' do
      colony.add_pop(priest)

      expect(priest.job_output[:unity]).to eq(5)
    end

    it 'increases the Unity output of Death Priests to 4' do
      colony.add_pop(death_priest)

      expect(death_priest.job_output[:unity]).to eq(4)
    end
  end
end
