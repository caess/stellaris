# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop'

RSpec.describe Job::Entertainer do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Entertainer')
  end

  it 'produces 1 Unity' do
    expect(job.output).to eq_resources({ unity: 1 })
  end

  it 'produces 10 amenities' do
    expect(job.amenities_output).to eq(10)
  end

  it 'requires 1 Consumer Good' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_entertainer }

  context 'when empire has Corporate Hedonism civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::CorporateHedonism] }
    end

    it 'provides 1% pop growth speed to colonies' do
      pop = Pop.new(species: species, colony: colony, job: described_class)

      expect(pop.colony_attribute_modifiers)
        .to eq_resource_modifier({ pop_growth_speed_percent: { additive: 1 } })
    end
  end

  context 'when empire has Pleasure Seekers civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::PleasureSeekers] }
    end

    it 'provides 1% pop growth speed to colonies' do
      pop = Pop.new(species: species, colony: colony, job: described_class)

      expect(pop.colony_attribute_modifiers)
        .to eq_resource_modifier({ pop_growth_speed_percent: { additive: 1 } })
    end
  end
end
