# frozen_string_literal: true

require 'job'

RSpec.describe Job::TechDrone do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Tech-Drone')
  end

  it 'provides 6 Energy' do
    expect(job.output).to eq_resources({ energy: 6 })
  end

  it { is_expected.to be_menial_drone }
  it { is_expected.to be_technician }
end
