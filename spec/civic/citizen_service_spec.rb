# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::CitizenService do
  subject(:civic) { described_class }

  it 'has the correct name' do
    expect(civic.name).to eq('Citizen Service')
  end

  it 'adds 2 Unity to Soldier output' do
    soldier = PopJob.new(worker: nil, job: Job::Soldier)

    expect(civic.job_output_modifiers(soldier)).to eq_resource_modifier({ unity: { additive: 2 } })
  end

  context 'when chosen for empire' do
    include_context 'with empire' do
      let(:civics) { [described_class] }
    end

    let(:soldier) { Pop.new(species: species, colony: colony, job: Job::Soldier) }

    it 'increases the Unity output of Soldiers to 2' do
      colony.add_pop(soldier)

      expect(soldier.job_output[:unity]).to eq(2)
    end
  end
end
