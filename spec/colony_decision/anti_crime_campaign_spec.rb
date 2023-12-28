# frozen_string_literal: true

require_relative '../../lib/colony_decision'
require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/pop_job'

RSpec.describe ColonyDecision::AntiCrimeCampaign do
  subject(:modifier) { described_class }

  let(:enforcer) { PopJob.new(worker: nil, job: Job::Enforcer) }
  let(:telepath) { PopJob.new(worker: nil, job: Job::Telepath) }
  let(:overseer) { PopJob.new(worker: nil, job: Job::Overseer) }

  it 'has the correct name' do
    expect(modifier.name).to eq('Anti-Crime Campaign')
  end

  it 'adds 2 Energy to the upkeep for Enforcers' do
    expect(modifier.job_upkeep_modifiers(enforcer))
      .to eq_resource_modifier({ energy: { additive: 2 } })
  end

  it 'increases the crime reduction for Enforcers by 10' do
    expect(modifier.job_colony_attribute_modifiers(enforcer))
      .to eq_resource_modifier({ crime: { additive: -10 } })
  end

  it 'adds 2 Energy to the upkeep for Telepaths' do
    expect(modifier.job_upkeep_modifiers(telepath))
      .to eq_resource_modifier({ energy: { additive: 2 } })
  end

  it 'increases the crime reduction for Telepaths by 10' do
    expect(modifier.job_colony_attribute_modifiers(telepath))
      .to eq_resource_modifier({ crime: { additive: -10 } })
  end

  it 'adds 2 Energy to the upkeep for Overseers' do
    expect(modifier.job_upkeep_modifiers(overseer))
      .to eq_resource_modifier({ energy: { additive: 2 } })
  end

  context 'when present on a colony' do
    include_context 'with empire' do
      let(:colony_modifiers) { [described_class] }
    end

    let(:overseer) { Pop.new(species: species, colony: colony, job: Job::Overseer) }

    it 'increases the upkeep for Overseers to 2 Energy' do
      colony.add_pop(overseer)

      expect(overseer.job_upkeep).to eq_resources({ energy: 2 })
    end
  end
end
