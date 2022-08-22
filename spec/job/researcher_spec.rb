# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::Researcher do
  subject(:job) { described_class }

  let(:expected_output) do
    {
      physics_research: 4,
      society_research: 4,
      engineering_research: 4
    }
  end

  it 'has the correct name' do
    expect(job.name).to eq('Researcher')
  end

  it 'produces 6 Research' do
    expect(job.output).to eq_resources(expected_output)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_researcher }
end
