# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop'

RSpec.describe Job::Priest do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Priest')
  end

  it 'produces 4 Unity' do
    expect(job.output).to eq_resources({ unity: 4 })
  end

  it 'produces 2 amenities' do
    expect(job.amenities_output).to eq(2)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_administrator }
  it { is_expected.to be_priest }

  context 'when empire has Exalted Priesthood civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::ExaltedPriesthood] }
    end

    let(:priest) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 5 Unity' do
      expect(priest.job_output).to eq_resources({ unity: 5 })
    end
  end
end
