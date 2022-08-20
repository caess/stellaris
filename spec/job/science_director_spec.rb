# frozen_string_literal: true

require 'job'

RSpec.describe Job::ScienceDirector do
  subject(:job) { described_class }

  let(:expected_output) do
    {
      physics_research: 6,
      society_research: 6,
      engineering_research: 6,
      unity: 2
    }
  end

  it 'has the correct name' do
    expect(job.name).to eq('Science Director')
  end

  it 'produces 6 Research and 2 Unity' do
    expect(job.output).to eq_resources(expected_output)
  end

  it 'produces 3 amenities' do
    expect(job.amenities_output).to eq(3)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_ruler }
  it { is_expected.to be_researcher }
end
