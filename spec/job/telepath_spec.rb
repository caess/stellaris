# frozen_string_literal: true

require 'job'

RSpec.describe Job::Telepath do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Telepath')
  end

  it 'produces 6 Unity' do
    expect(job.output).to eq_resources({ unity: 6 })
  end

  it 'reduces crime by 35 for the colony' do
    expect(job.colony_attribute_modifiers).to eq_resource_modifier({ crime: { additive: -35 } })
  end

  it 'improves other jobs\' output by 5%' do
    expect(job.all_job_output_modifiers(nil)).to eq(
      ResourceModifier::MultiplyAllProducedResources.new(0.05)
    )
  end

  it 'requires 1 Energy' do
    expect(job.upkeep).to eq_resources({ energy: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_administrator }
  it { is_expected.to be_telepath }
end
