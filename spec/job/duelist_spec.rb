# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::Duelist do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Duelist')
  end

  it 'produces 2 Unity' do
    expect(job.output).to eq_resources({ unity: 2 })
  end

  it 'produces 10 amenities' do
    expect(job.amenities_output).to eq(10)
  end

  it 'provides 2 naval capacity to the empire' do
    expect(job.empire_attribute_modifiers).to eq_resource_modifier({ naval_capacity: { additive: 2 } })
  end

  it 'requires 1 Alloy' do
    expect(job.upkeep).to eq_resources({ alloys: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_entertainer }
end
