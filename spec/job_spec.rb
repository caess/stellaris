# frozen_string_literal: true

require 'job'

RSpec.describe(Job) do
  subject(:job) { described_class.new(name: 'Unemployed') }

  it 'sets its name' do
    expect(job.name).to eq('Unemployed')
  end

  it 'has no output' do
    expect(job.output).to be_empty
  end

  it 'has no upkeep' do
    expect(job.upkeep).to be_empty
  end

  it 'has no amenities output' do
    expect(job.amenities_output).to eq(0)
  end

  it 'has no stability modifier' do
    expect(job.stability_modifier).to eq(0)
  end

  # Strata
  it 'is not ruler strata' do
    expect(job).not_to be_ruler
  end

  it 'is not specialist strata' do
    expect(job).not_to be_specialist
  end

  it 'is not worker strata' do
    expect(job).not_to be_worker
  end

  it 'is not slave strata' do
    expect(job).not_to be_slave
  end

  it 'is not a menial drone' do
    expect(job).not_to be_menial_drone
  end

  it 'is not a complex drone' do
    expect(job).not_to be_complex_drone
  end

  # Categories
  it 'is not a farmer' do
    expect(job).not_to be_farmer
  end

  it 'is not a miner' do
    expect(job).not_to be_miner
  end

  it 'is not a strategic resource miner' do
    expect(job).not_to be_strategic_resource_miner
  end

  it 'is not livestock' do
    expect(job).not_to be_livestock
  end

  it 'is not a technician' do
    expect(job).not_to be_technician
  end

  it 'is not a politican' do
    expect(job).not_to be_politician
  end

  it 'is not an executive' do
    expect(job).not_to be_executive
  end

  it 'is not an noble' do
    expect(job).not_to be_noble
  end

  it 'is not an administrator' do
    expect(job).not_to be_administrator
  end

  it 'is not a manager' do
    expect(job).not_to be_manager
  end

  it 'is not a priest' do
    expect(job).not_to be_priest
  end

  it 'is not a telepath' do
    expect(job).not_to be_telepath
  end

  it 'is not a researcher' do
    expect(job).not_to be_researcher
  end

  it 'is not a metallurgist' do
    expect(job).not_to be_metallurgist
  end

  it 'is not a culture worker' do
    expect(job).not_to be_culture_worker
  end

  it 'is not an evaluator' do
    expect(job).not_to be_evaluator
  end

  it 'is not a refiner' do
    expect(job).not_to be_refiner
  end

  it 'is not a translucer' do
    expect(job).not_to be_translucer
  end

  it 'is not a chemist' do
    expect(job).not_to be_chemist
  end

  it 'is not an artisan' do
    expect(job).not_to be_artisan
  end

  it 'is not a bio-trophy' do
    expect(job).not_to be_bio_trophy
  end

  it 'is not a pop assembler' do
    expect(job).not_to be_pop_assembler
  end

  it 'is not a necro-apprentice' do
    expect(job).not_to be_necro_apprentice
  end

  it 'is not an merchant' do
    expect(job).not_to be_merchant
  end

  it 'is not a entertainer' do
    expect(job).not_to be_entertainer
  end

  it 'is not a soldier' do
    expect(job).not_to be_soldier
  end

  it 'is not a enforcer' do
    expect(job).not_to be_enforcer
  end

  it 'is not a doctor' do
    expect(job).not_to be_doctor
  end
end
