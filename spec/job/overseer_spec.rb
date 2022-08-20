# frozen_string_literal: true

require 'job'

RSpec.describe Job::Overseer do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Overseer')
  end

  it 'reduces crime by 25 and provides 2 defense armies to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(
      { crime: { additive: -25 }, defense_armies: { additive: 2 } }
    )
  end

  it 'increases happiness by 25%' do
    expect(job.pop_happiness_modifiers).to eq(25)
  end

  it { is_expected.to be_slave }
  it { is_expected.to be_enforcer }
end
