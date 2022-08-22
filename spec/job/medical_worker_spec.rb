# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::MedicalWorker do
  subject(:job) { described_class }

  let(:expected_colony_modifiers) do
    {
      pop_growth_speed_percent: { additive: 5 },
      organic_pop_assembly_speed_percent: { additive: 5 }
    }
  end

  it 'has the correct name' do
    expect(job.name).to eq('Medical Worker')
  end

  it 'produces 5 amenities' do
    expect(job.amenities_output).to eq(5)
  end

  it 'provides 5% pop growth speed and 5% organic pop assembly speed to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(expected_colony_modifiers)
  end

  it 'provides 2.5% Habitability to the colony' do
    expect(job.habitability_modifier).to eq(2.5)
  end

  it 'requires 1 Consumer Good' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_doctor }
end
