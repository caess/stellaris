# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::ByzantineBureaucracy do
  subject(:civic) { described_class }

  let(:bureaucrat) { PopJob.new(worker: nil, job: Job::Bureaucrat) }
  let(:death_chronicler) { PopJob.new(worker: nil, job: Job::DeathChronicler) }

  it 'has the correct name' do
    expect(civic.name).to eq('Byzantine Bureaucracy')
  end

  it 'adds 1 Unity to Bureaucrat output' do
    expect(civic.job_output_modifiers(bureaucrat))
      .to eq_resource_modifier({ unity: { additive: 1 } })
  end

  it 'adds 1 Unity to Death Chronicler output' do
    expect(civic.job_output_modifiers(death_chronicler))
      .to eq_resource_modifier({ unity: { additive: 1 } })
  end

  it 'adds 1 to the stability provided by Bureaucrats' do
    expect(civic.job_stability_modifier(bureaucrat)).to eq(1)
  end

  context 'when chosen for empire' do
    include_context 'with empire' do
      let(:civics) { [described_class] }
    end

    let(:bureaucrat) { Pop.new(species: species, colony: colony, job: Job::Bureaucrat) }
    let(:death_chronicler) { Pop.new(species: species, colony: colony, job: Job::DeathChronicler) }

    it 'increases the Unity output of Death Chroniclers to 3' do
      colony.add_pop(death_chronicler)

      expect(death_chronicler.job_output[:unity]).to eq(3)
    end
  end
end
