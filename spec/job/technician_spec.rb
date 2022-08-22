# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::Technician do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Technician')
  end

  it 'produces 6 Energy' do
    expect(job.output).to eq_resources({ energy: 6 })
  end

  it { is_expected.to be_worker }
  it { is_expected.to be_technician }
end
