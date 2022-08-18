# frozen_string_literal: true

require_relative '../stellaris/lib/stellaris'

RSpec.describe 'species traits' do
  describe 'Lithoid' do
    subject { SpeciesTrait::Lithoid }

    it 'has the correct name' do
      expect(subject.name).to eq('Lithoid')
    end

    it 'modifies the output of Colonist jobs' do
      pop_job = PopJob.new(
        job: Job::Colonist,
        worker: nil
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({
                               food: { additive: -1 },
                               minerals: { additive: 1 }
                             })
      )
    end

    it 'modifies the upkeep of Reassigner jobs' do
      pop_job = PopJob.new(
        job: Job::Reassigner,
        worker: nil
      )

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(
        ResourceModifier.new({
                               food: { additive: -2 },
                               minerals: { additive: 2 }
                             })
      )
    end

    it 'modifies the upkeep of Necrophyte jobs' do
      pop_job = PopJob.new(
        job: Job::Necrophyte,
        worker: nil
      )

      expect(subject.job_upkeep_modifiers(pop_job)).to eq(
        ResourceModifier.new({
                               food: { additive: -1 },
                               minerals: { additive: 1 }
                             })
      )
    end

    it 'modifies the output of Livestock jobs' do
      pop_job = PopJob.new(worker: nil, job: Job::Livestock)

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({
                               food: { additive: -4 },
                               minerals: { additive: 2 }
                             })
      )
    end
  end

  describe 'Machine' do
    subject { SpeciesTrait::Machine }

    it 'has the correct name' do
      expect(subject.name).to eq('Machine')
    end

    it 'modifies the worker housing modifier for Servants' do
      pop_job = PopJob.new(worker: nil, job: Job::Servant)

      expect(subject.job_worker_housing_modifier(pop_job)).to eq(
        ResourceModifier.new({ housing: { additive: 0.5 } })
      )
    end
  end

  describe 'Mechanical' do
    subject { SpeciesTrait::Mechanical }

    it 'has the correct name' do
      expect(subject.name).to eq('Mechanical')
    end

    it 'modifies the worker housing modifier for Servants' do
      pop_job = PopJob.new(worker: nil, job: Job::Servant)

      expect(subject.job_worker_housing_modifier(pop_job)).to eq(
        ResourceModifier.new({ housing: { additive: 0.5 } })
      )
    end

    context 'as founder species' do
      it 'modifies the Technicial job output' do
        pop_job = PopJob.new(worker: nil, job: Job::Technician)

        expect(subject.founder_species_job_output_modifiers(pop_job)).to eq(
          ResourceModifier.new({
                                 energy: { additive: 2 }
                               })
        )
      end

      it 'modifies the Farmer job output' do
        pop_job = PopJob.new(worker: nil, job: Job::Farmer)

        expect(subject.founder_species_job_output_modifiers(pop_job)).to eq(
          ResourceModifier.new({
                                 food: { additive: -1 }
                               })
        )
      end
    end
  end
end

RSpec.describe 'end-to-end tests' do
  describe 'Lithoid' do
    let(:species) do
      Species.new(
        living_standard: nil,
        traits: [SpeciesTrait::Lithoid]
      )
    end

    it 'modifies the output of Colonist jobs' do
      pop = Pop.new(
        species: species,
        colony: nil,
        job: Job::Colonist
      )

      expect(pop.output).to eq(ResourceGroup.new({ minerals: 1 }))
    end

    it 'modifies the upkeep of Reassigner jobs' do
      pop = Pop.new(
        species: species,
        colony: nil,
        job: Job::Reassigner
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
                                                       consumer_goods: 2,
                                                       minerals: 2
                                                     }))
    end

    it 'modifies the upkeep of Necrophyte jobs' do
      pop = Pop.new(
        species: species,
        colony: nil,
        job: Job::Necrophyte
      )

      expect(pop.job.upkeep).to eq(ResourceGroup.new({
                                                       consumer_goods: 1,
                                                       minerals: 1
                                                     }))
    end

    it 'modifies the output of Livestock jobs' do
      pop = Pop.new(
        species: species,
        colony: nil,
        job: Job::Livestock
      )

      expect(pop.output).to eq(ResourceGroup.new({ minerals: 2 }))
    end
  end

  describe 'Machine' do
    let(:species) do
      Species.new(
        living_standard: nil,
        traits: [SpeciesTrait::Machine]
      )
    end

    it 'modifies the worker housing modifier of Servant jobs' do
      pop = Pop.new(
        species: species,
        colony: nil,
        job: Job::Servant
      )

      expect(pop.job.worker_housing_modifier).to eq(
        ResourceModifier.new({ housing: { additive: 0 } })
      )
    end
  end

  describe 'Mechanical' do
    let(:species) do
      Species.new(
        living_standard: nil,
        traits: [SpeciesTrait::Mechanical]
      )
    end

    it 'modifies the worker housing modifier of Servant jobs' do
      pop = Pop.new(
        species: species,
        colony: nil,
        job: Job::Servant
      )

      expect(pop.job.worker_housing_modifier).to eq(
        ResourceModifier.new({ housing: { additive: 0 } })
      )
    end

    context 'as founder species' do
      let(:ruler) { Leader.new(level: 0) }
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it 'modifies the output of Technician jobs' do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Technician
        )

        expect(pop.output).to eq(ResourceGroup.new({ energy: 8 }))
      end

      it 'modifies the output of Farmer jobs' do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Farmer
        )

        expect(pop.output).to eq(ResourceGroup.new({ food: 5 }))
      end
    end
  end
end
