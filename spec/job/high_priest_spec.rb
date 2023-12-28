# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop'

RSpec.describe Job::HighPriest do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('High Priest')
  end

  it 'produces 6 Unity' do
    expect(job.output).to eq_resources({ unity: 6 })
  end

  it 'produces 5 amenities' do
    expect(job.amenities_output).to eq(5)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_ruler }
  it { is_expected.to be_administrator }
  it { is_expected.to be_priest }

  context 'when empire has Exalted Priesthood civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::ExaltedPriesthood] }
    end

    let(:high_priest) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 7 Unity' do
      expect(high_priest.job_output).to eq_resources({ unity: 7 })
    end
  end
end
