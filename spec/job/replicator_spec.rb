# frozen_string_literal: true

require 'job'

RSpec.describe Job::Replicator do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Replicator')
  end

  it 'provides 1 monthly mechanical pop assembly point to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier(
      { monthly_mechanical_pop_assembly: { additive: 1 } }
    )
  end

  it 'requires 1 Alloy' do
    expect(job.upkeep).to eq_resources({ alloys: 1 })
  end

  it { is_expected.to be_complex_drone }
  it { is_expected.to be_pop_assembler }
end
