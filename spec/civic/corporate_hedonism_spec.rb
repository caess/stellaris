# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::CorporateHedonism do
  subject(:civic) { described_class }

  let(:entertainer) { PopJob.new(worker: nil, job: Job::Entertainer) }

  it 'has the correct name' do
    expect(civic.name).to eq('Corporate Hedonism')
  end

  it 'adds 1% pop growth speed to Entertainers' do
    expect(civic.job_colony_attribute_modifiers(entertainer))
      .to eq_resource_modifier({ pop_growth_speed_percent: { additive: 1 } })
  end

  context 'when chosen for empire' do
    include_context 'with empire' do
      let(:civics) { [described_class] }
    end

    let(:entertainer) { Pop.new(species: species, colony: colony, job: Job::Entertainer) }

    it 'gives Entertainers a 1% pop growth speed increase to their colonies' do
      colony.add_pop(entertainer)

      expect(entertainer.colony_attribute_modifiers[:pop_growth_speed_percent]).to eq({ additive: 1 })
    end
  end
end
