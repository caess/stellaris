# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::WarriorDrone do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Warrior Drone')
  end

  it 'provides 3 defense armies to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(
      { defense_armies: { additive: 3 } }
    )
  end

  it 'provides 4 naval capacity for the empire' do
    expect(job.empire_attribute_modifiers).to eq_resource_modifier(
      { naval_capacity: { additive: 4 } }
    )
  end

  it { is_expected.to be_menial_drone }
  it { is_expected.to be_soldier }
end
