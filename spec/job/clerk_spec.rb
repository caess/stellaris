# frozen_string_literal: true

require_relative '../../lib/job'
require_relative '../../lib/pop'
require_relative '../../lib/tradition'

RSpec.describe Job::Clerk do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Clerk')
  end

  it 'produces 4 Trade' do
    expect(job.output).to eq_resources({ trade: 4 })
  end

  it 'produces 2 amenities' do
    expect(job.amenities_output).to eq(2)
  end

  it { is_expected.to be_worker }

  context 'when empire has Trickle Up Economics tradition' do
    include_context 'with empire' do
      let(:traditions) { [Tradition::TrickleUpEconomics] }
    end

    let(:clerk) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 5 Trade' do
      expect(clerk.job_output).to eq_resources({ trade: 5 })
    end
  end
end
