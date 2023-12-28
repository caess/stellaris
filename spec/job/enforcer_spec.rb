# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/colony_decision'
require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/tradition'

RSpec.describe Job::Enforcer do
  subject(:job) { described_class }

  let(:expected_colony_modifiers) do
    {
      crime: { additive: -25 },
      defense_armies: { additive: 2 }
    }
  end

  it 'has the correct name' do
    expect(job.name).to eq('Enforcer')
  end

  it 'provides 1 stability' do
    expect(job.stability_modifier).to eq(1)
  end

  it 'reduces 25 crime and provides 2 defense armies' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(expected_colony_modifiers)
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_enforcer }

  context 'when colony has Anti-Crime Campaign modifier' do
    include_context 'with empire' do
      let(:colony_modifiers) { [ColonyDecision::AntiCrimeCampaign] }
    end

    let(:enforcer) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'reduces 35 crime and provides 2 defense armies' do
      expect(enforcer.colony_attribute_modifiers)
        .to eq_resource_modifier({ crime: { additive: -35 }, defense_armies: { additive: 2 } })
    end

    it 'requires 2 Energy' do
      expect(enforcer.job_upkeep).to eq_resources({ energy: 2 })
    end
  end

  context 'when empire has Police State civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::PoliceState] }

      let(:enforcer) { Pop.new(species: species, colony: colony, job: described_class) }

      it 'provides 1 Unity' do
        expect(enforcer.job_output).to eq_resources({ unity: 1 })
      end
    end
  end

  context 'when empire has Judgment Corps tradition' do
    include_context 'with empire' do
      let(:traditions) { [Tradition::JudgmentCorps] }

      let(:enforcer) { Pop.new(species: species, colony: colony, job: described_class) }

      it 'provides 1 Unity' do
        expect(enforcer.job_output).to eq_resources({ unity: 1 })
      end
    end
  end
end
