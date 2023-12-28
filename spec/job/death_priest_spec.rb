# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop'

RSpec.describe Job::DeathPriest do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Death Priest')
  end

  it 'produces 3 Unity and 1 Society Research' do
    expect(job.output).to eq_resources({ unity: 3, society_research: 1 })
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

    let(:death_priest) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 4 Unity and 1 Society Research' do
      expect(death_priest.job_output).to eq_resources({ unity: 4, society_research: 1 })
    end
  end

  context 'when a sacrifice edict is active' do
    context 'when empire has Bounty sacfrice edict' do
      include_context 'with empire' do
        let(:edicts) { [Edict::BountySacrificeEdict] }
      end

      let(:death_priest) { Pop.new(species: species, colony: colony, job: described_class) }

      it 'produces 6 Unity and 1 Society Research' do
        expect(death_priest.job_output).to eq_resources({ unity: 6, society_research: 1 })
      end
    end

    context 'when empire has Harmony sacfrice edict' do
      include_context 'with empire' do
        let(:edicts) { [Edict::HarmonySacrificeEdict] }
      end

      let(:death_priest) { Pop.new(species: species, colony: colony, job: described_class) }

      it 'produces 6 Unity and 1 Society Research' do
        expect(death_priest.job_output).to eq_resources({ unity: 6, society_research: 1 })
      end
    end

    context 'when empire has Togetherness sacfrice edict' do
      include_context 'with empire' do
        let(:edicts) { [Edict::TogethernessSacrificeEdict] }
      end

      let(:death_priest) { Pop.new(species: species, colony: colony, job: described_class) }

      it 'produces 6 Unity and 1 Society Research' do
        expect(death_priest.job_output).to eq_resources({ unity: 6, society_research: 1 })
      end
    end
  end
end
