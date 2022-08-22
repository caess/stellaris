# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::Roboticist do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Roboticist')
  end

  it 'provides 2 Monthly Mechanical Pop Assembly points to the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier({ monthly_mechanical_pop_assembly: { additive: 2 } })
  end

  it 'requires 2 Alloys' do
    expect(job.upkeep).to eq_resources(alloys: 2)
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_pop_assembler }
end
