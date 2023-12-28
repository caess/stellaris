# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/colony_decision'
require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/tradition'

RSpec.describe Job::Telepath do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Telepath')
  end

  it 'produces 6 Unity' do
    expect(job.output).to eq_resources({ unity: 6 })
  end

  it 'reduces crime by 35 for the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier({ crime: { additive: -35 } })
  end

  it 'improves other jobs\' output by 5%' do
    expect(job.all_job_output_modifiers(nil)).to eq(
      ResourceModifier::MultiplyAllProducedResources.new(0.05)
    )
  end

  it 'requires 1 Energy' do
    expect(job.upkeep).to eq_resources({ energy: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_administrator }
  it { is_expected.to be_telepath }

  context 'when empire has Thought Enforcement edict' do
    include_context 'with empire' do
      let(:edicts) { [Edict::ThoughtEnforcement] }
    end

    let(:telepath) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'reduces crime by 40' do
      expect(telepath.colony_attribute_modifiers).to eq_resource_modifier({ crime: { additive: -40 } })
    end
  end

  context 'when colony has Anti-Crime Campaign modifier' do
    include_context 'with empire' do
      let(:colony_modifiers) { [ColonyDecision::AntiCrimeCampaign] }
    end

    let(:telepath) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'reduces crime by 45' do
      expect(telepath.colony_attribute_modifiers).to eq_resource_modifier({ crime: { additive: -45 } })
    end

    it 'requires 3 energy' do
      expect(telepath.job_upkeep).to eq_resources({ energy: 3 })
    end
  end

  context 'when empire has Police State civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::PoliceState] }
    end

    let(:telepath) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 7 unity' do
      expect(telepath.job_output).to eq_resources({ unity: 7 })
    end
  end

  context 'when empire has Judgment Corps tradition' do
    include_context 'with empire' do
      let(:traditions) { [Tradition::JudgmentCorps] }
    end

    let(:telepath) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 7 unity' do
      expect(telepath.job_output).to eq_resources({ unity: 7 })
    end
  end
end
