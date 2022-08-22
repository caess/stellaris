# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::AgriDrone do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Agri-Drone')
  end

  it 'provides 6 Food' do
    expect(job.output).to eq_resources({ food: 6 })
  end

  it { is_expected.to be_menial_drone }
  it { is_expected.to be_farmer }
end
