# frozen_string_literal: true

require_relative '../lib/building'
require_relative '../lib/job'
require_relative '../lib/pop_job'
require_relative '../lib/resource_group'
require_relative '../lib/resource_modifier'

RSpec.describe Building do
  subject(:building) { described_class.new(name: '') }

  it 'provides no housing' do
    expect(building.housing).to eq(0)
  end

  it 'provides no amenities' do
    expect(building.amenities_output).to eq(0)
  end

  it 'provides no stability modifier' do
    expect(building.stability_modifier).to eq(0)
  end

  it 'has no colony attribute modifier' do
    expect(building.colony_attribute_modifiers).to be_empty
  end

  it 'provides no jobs' do
    expect(building.max_jobs).to be_empty
  end

  it 'has no upkeep' do
    expect(building.upkeep).to be_empty
  end
end
