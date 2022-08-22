# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::MaintenanceDrone do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Maintenance Drone')
  end

  it 'produces 4 amenities' do
    expect(job.amenities_output).to eq(4)
  end

  it { is_expected.to be_menial_drone }
end
