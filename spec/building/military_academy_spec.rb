# frozen_string_literal: true

require_relative '../../lib/building'
require_relative '../../lib/job'

RSpec.describe Building::MilitaryAcademy do
  subject(:building) { described_class }

  it 'has the correct name' do
    expect(building.name).to eq('Military Academy')
  end

  it 'provides 2 Soldier jobs' do
    expect(building.max_jobs).to eq({ Job::Soldier => 2 })
  end

  it 'adds 100 starting experience to armies' do
    expect(building.colony_attribute_modifiers)
      .to eq_resource_modifier({ army_starting_experience: { additive: 100 } })
  end

  it 'requires 2 Energy' do
    expect(building.upkeep).to eq_resources({ energy: 2 })
  end
end
