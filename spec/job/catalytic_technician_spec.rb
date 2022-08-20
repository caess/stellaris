# frozen_string_literal: true

require 'job'

RSpec.describe Job::CatalyticTechnician do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Catalytic Technician')
  end

  it 'produces 3 Alloys' do
    expect(job.output).to eq_resources({ alloys: 3 })
  end

  it 'requires 9 Food' do
    expect(job.upkeep).to eq_resources({ food: 9 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_metallurgist }
end
