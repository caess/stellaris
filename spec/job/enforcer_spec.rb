# frozen_string_literal: true

require 'job'

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
end
