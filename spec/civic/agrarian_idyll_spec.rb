# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::AgrarianIdyll do
  subject(:civic) { described_class }

  it 'has the correct name' do
    expect(civic.name).to eq('Agrarian Idyll')
  end

  it 'adds 2 amenities to Farmer output' do
    farmer = PopJob.new(worker: nil, job: Job::Farmer)

    expect(civic.job_amenities_output_modifier(farmer)).to eq(2)
  end

  context 'when chosen for empire' do
    include_context 'with empire' do
      let(:civics) { [described_class] }
    end

    it 'increases the amenities output of Farmers to 2' do
      farmer = Pop.new(species: species, colony: colony, job: Job::Farmer)

      expect(farmer.amenities_output).to eq(2)
    end
  end
end
