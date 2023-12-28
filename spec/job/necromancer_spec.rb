# frozen_string_literal: true

require_relative '../../lib/colony_decision'
require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/technology'

RSpec.describe Job::Necromancer do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Necromancer')
  end

  it 'produces 6 Physics Research and 6 Society Research' do
    expect(job.output).to eq_resources({
                                         physics_research: 6,
                                         society_research: 6
                                       })
  end

  it 'provides 3 defense armies for the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(
      { defense_armies: { additive: 3 } }
    )
  end

  it 'provides 2 naval capacity to the empire' do
    expect(job.empire_attribute_modifiers).to eq_resource_modifier(
      { naval_capacity: { additive: 2 } }
    )
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_researcher }

  context 'when empire has Ground Defense Planning technology' do
    include_context 'with empire' do
      let(:technologies) { [Technology::GroundDefensePlanning] }
    end

    let(:necromancer) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'provides 4 naval capacity to the empire' do
      expect(necromancer.empire_attribute_modifiers).to eq_resource_modifier(
        { naval_capacity: { additive: 4 } }
      )
    end
  end

  context 'when colony has Martial Law modifier' do
    include_context 'with empire' do
      let(:colony_modifiers) { [ColonyDecision::MartialLaw] }
    end

    let(:necromancer) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'provides 5 defense armies' do
      expect(necromancer.colony_attribute_modifiers).to eq_resource_modifier({ defense_armies: { additive: 5 } })
    end
  end
end
