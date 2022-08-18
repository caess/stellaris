require_relative "../stellaris/lib/stellaris"

RSpec.describe "technologies" do
  describe "Society technologies" do
    describe "Ground Defense Planning" do
      subject { Technology::GroundDefensePlanning }

      it "has the correct name" do
        expect(subject.name).to eq("Ground Defense Planning")
      end

      it "modifies the empire attribute modifiers for Necromancers" do
        pop_job = PopJob.new(worker: nil, job: Job::Necromancer)

        expect(subject.job_empire_attribute_modifiers(pop_job)).to eq(
          ResourceModifier.new({
            naval_capacity: { additive: 2 },
          })
        )
      end

      it "modifies the empire attribute modifiers for Soldiers" do
        pop_job = PopJob.new(worker: nil, job: Job::Soldier)

        expect(subject.job_empire_attribute_modifiers(pop_job)).to eq(
          ResourceModifier.new({
            naval_capacity: { additive: 2 },
          })
        )
      end

      it "modifies the empire attribute modifiers for Warrior Drones" do
        pop_job = PopJob.new(worker: nil, job: Job::WarriorDrone)

        expect(subject.job_empire_attribute_modifiers(pop_job)).to eq(
          ResourceModifier.new({
            naval_capacity: { additive: 2 },
          })
        )
      end
    end
  end
end

RSpec.describe "end-to-end tests" do
  let(:species) do
    Species.new(
      living_standard: nil,
    )
  end
  let(:ruler) { Leader.new(level: 0) }

  describe "Society technologies" do
    describe "Ground Defense Planning" do
      let(:empire) do
        Empire.new(
          founder_species: species,
          ruler: ruler,
          technologies: [Technology::GroundDefensePlanning],
        )
      end
      let(:sector) { Sector.new(empire: empire) }
      let(:colony) { Colony.new(type: nil, size: nil, sector: sector) }

      it "modifies the empire attribute modifiers of Necromancers" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Necromancer,
        )

        expect(pop.job.empire_attribute_modifiers).to eq(ResourceModifier.new({
          naval_capacity: { additive: 4 },
        }))
      end

      it "modifies the empire attribute modifiers of Soldiers" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::Soldier,
        )

        expect(pop.job.empire_attribute_modifiers).to eq(ResourceModifier.new({
          naval_capacity: { additive: 6 },
        }))
      end

      it "modifies the empire attribute modifiers of Warrior Drones" do
        pop = Pop.new(
          species: species,
          colony: colony,
          job: Job::WarriorDrone,
        )

        expect(pop.job.empire_attribute_modifiers).to eq(ResourceModifier.new({
          naval_capacity: { additive: 6 },
        }))
      end
    end
  end
end
