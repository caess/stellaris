# frozen_string_literal: true

require_relative '../../lib/colony_decision'
require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/pop_job'

RSpec.describe ColonyDecision::MartialLaw do
  subject(:modifier) { described_class }

  it 'has the correct name' do
    expect(modifier.name).to eq('Martial Law')
  end

  it 'increases the number of defense armies provided by Necromancers by 2' do
    necromancer = PopJob.new(worker: nil, job: Job::Necromancer)

    expect(modifier.job_colony_attribute_modifiers(necromancer))
      .to eq_resource_modifier({ defense_armies: { additive: 2 } })
  end

  it 'increases the stability provided by Soldiers by 5' do
    soldier = PopJob.new(worker: nil, job: Job::Soldier)

    expect(modifier.job_stability_modifier(soldier)).to eq(5)
  end

  context 'when present on a colony' do
    include_context 'with empire' do
      let(:colony_modifiers) { [described_class] }
    end

    let(:soldier) { Pop.new(species: species, colony: colony, job: Job::Soldier) }

    it 'increases the stability provided by Soldiers to 5' do
      colony.add_pop(soldier)

      expect(soldier.stability_modifier).to eq(5)
    end
  end
end
