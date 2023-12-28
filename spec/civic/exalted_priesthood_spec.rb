# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::ExaltedPriesthood do
  subject(:civic) { described_class }

  it 'has the correct name' do
    expect(civic.name).to eq('Exalted Priesthood')
  end

  it 'adds 1 Unity to priest output' do
    job = instance_double(Job)
    allow(job).to receive(:priest?).and_return(true)

    priest = PopJob.new(worker: nil, job: job)

    expect(civic.job_output_modifiers(priest)).to eq_resource_modifier({ unity: { additive: 1 } })
  end
end
