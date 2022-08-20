# frozen_string_literal: true

require 'job'

RSpec.describe Job::SpawningDrone do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Spawning Drone')
  end

  it 'produces 5 amenities' do
    expect(job.amenities_output).to eq(5)
  end

  it 'provides 2 monthly organic pop assembly points to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(
      { monthly_organic_pop_assembly: { additive: 2 } }
    )
  end

  it 'requires 5 Food' do
    expect(job.upkeep).to eq_resources({ food: 5 })
  end

  it { is_expected.to be_complex_drone }
end
