# frozen_string_literal: true

require 'job'

RSpec.describe Job::Necrophyte do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Necrophyte')
  end

  it 'produces 1.5 Unity' do
    expect(job.output).to eq_resources({ unity: 1.5 })
  end

  it 'produces 5 amenities' do
    expect(job.amenities_output).to eq(5)
  end

  it 'requires 1 Consumer Good and 1 Food' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 1, food: 1 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_pop_assembler }
  it { is_expected.to be_necro_apprentice }
end
