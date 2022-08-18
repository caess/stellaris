require_relative "../stellaris/lib/stellaris"

RSpec.describe(Job) do
  subject { Job.new(name: "Unemployed") }

  it "sets its name" do
    expect(subject.name).to eq("Unemployed")
  end

  it "has no output" do
    expect(subject.output).to be_empty
  end

  it "has no upkeep" do
    expect(subject.upkeep).to be_empty
  end

  it "has no amenities output" do
    expect(subject.amenities_output).to eq(0)
  end

  it "has no stability modifier" do
    expect(subject.stability_modifier).to eq(0)
  end

  # Strata
  it "is not ruler strata" do
    expect(subject.ruler?).to be_falsey
  end

  it "is not specialist strata" do
    expect(subject.specialist?).to be_falsey
  end

  it "is not worker strata" do
    expect(subject.worker?).to be_falsey
  end

  it "is not slave strata" do
    expect(subject.slave?).to be_falsey
  end

  it "is not a menial drone" do
    expect(subject.menial_drone?).to be_falsey
  end

  it "is not a complex drone" do
    expect(subject.complex_drone?).to be_falsey
  end

  # Categories
  it "is not a farmer" do
    expect(subject.farmer?).to be_falsey
  end

  it "is not a miner" do
    expect(subject.miner?).to be_falsey
  end

  it "is not a strategic resource miner" do
    expect(subject.strategic_resource_miner?).to be_falsey
  end

  it "is not livestock" do
    expect(subject.livestock?).to be_falsey
  end

  it "is not a technician" do
    expect(subject.technician?).to be_falsey
  end

  it "is not a politican" do
    expect(subject.politician?).to be_falsey
  end

  it "is not an executive" do
    expect(subject.executive?).to be_falsey
  end

  it "is not an noble" do
    expect(subject.noble?).to be_falsey
  end

  it "is not an administrator" do
    expect(subject.administrator?).to be_falsey
  end

  it "is not a manager" do
    expect(subject.manager?).to be_falsey
  end

  it "is not a priest" do
    expect(subject.priest?).to be_falsey
  end

  it "is not a telepath" do
    expect(subject.telepath?).to be_falsey
  end

  it "is not a researcher" do
    expect(subject.researcher?).to be_falsey
  end

  it "is not a metallurgist" do
    expect(subject.metallurgist?).to be_falsey
  end

  it "is not a culture worker" do
    expect(subject.culture_worker?).to be_falsey
  end

  it "is not an evaluator" do
    expect(subject.evaluator?).to be_falsey
  end

  it "is not a refiner" do
    expect(subject.refiner?).to be_falsey
  end

  it "is not a translucer" do
    expect(subject.translucer?).to be_falsey
  end

  it "is not a chemist" do
    expect(subject.chemist?).to be_falsey
  end

  it "is not an artisan" do
    expect(subject.artisan?).to be_falsey
  end

  it "is not a bio-trophy" do
    expect(subject.bio_trophy?).to be_falsey
  end

  it "is not a pop assembler" do
    expect(subject.pop_assembler?).to be_falsey
  end

  it "is not a necro-apprentice" do
    expect(subject.necro_apprentice?).to be_falsey
  end

  it "is not an merchant" do
    expect(subject.merchant?).to be_falsey
  end

  it "is not a entertainer" do
    expect(subject.entertainer?).to be_falsey
  end

  it "is not a soldier" do
    expect(subject.soldier?).to be_falsey
  end

  it "is not a enforcer" do
    expect(subject.enforcer?).to be_falsey
  end

  it "is not a doctor" do
    expect(subject.doctor?).to be_falsey
  end
end

RSpec.context("ruler jobs") do
  describe "Job::Politician" do
    subject { Job::Politician }

    it "has the correct name" do
      expect(subject.name).to eq("Politician")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ unity: 6 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(3)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a ruler" do
      expect(subject.ruler?).to be_truthy
    end

    it "is a politician" do
      expect(subject.politician?).to be_truthy
    end
  end

  describe "Job::Executive" do
    subject { Job::Executive }

    it "has the correct name" do
      expect(subject.name).to eq("Executive")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        unity: 6,
        trade: 4,
      }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(3)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a ruler" do
      expect(subject.ruler?).to be_truthy
    end

    it "is a politician" do
      expect(subject.politician?).to be_truthy
    end

    it "is an executive" do
      expect(subject.executive?).to be_truthy
    end
  end

  describe "Job::Merchant" do
    subject { Job::Merchant }

    it "has the correct name" do
      expect(subject.name).to eq("Merchant")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ trade: 12 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(3)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a ruler" do
      expect(subject.ruler?).to be_truthy
    end

    it "is a merchant" do
      expect(subject.merchant?).to be_truthy
    end
  end

  describe "Job::ScienceDirector" do
    subject { Job::ScienceDirector }

    it "has the correct name" do
      expect(subject.name).to eq("Science Director")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        physics_research: 6,
        society_research: 6,
        engineering_research: 6,
        unity: 2,
      }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(3)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a ruler" do
      expect(subject.ruler?).to be_truthy
    end

    it "is a researcher" do
      expect(subject.researcher?).to be_truthy
    end
  end

  describe "Job::HighPriest" do
    subject { Job::HighPriest }

    it "has the correct name" do
      expect(subject.name).to eq("High Priest")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ unity: 6 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(5)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a ruler" do
      expect(subject.ruler?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end

    it "is a priest" do
      expect(subject.priest?).to be_truthy
    end
  end

  describe "Job::Noble" do
    subject { Job::Noble }

    it "has the correct name" do
      expect(subject.name).to eq("Noble")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ unity: 6 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(3)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new(consumer_goods: 2))
    end

    it "has the correct stability modifier" do
      expect(subject.stability_modifier).to eq(2)
    end

    it "is a ruler" do
      expect(subject.ruler?).to be_truthy
    end

    it "is a politician" do
      expect(subject.politician?).to be_truthy
    end

    it "is a noble" do
      expect(subject.noble?).to be_truthy
    end
  end
end

RSpec.describe "specialist jobs" do
  describe "Job::Metallurgist" do
    subject { Job::Metallurgist }

    it "has the correct name" do
      expect(subject.name).to eq("Metallurgist")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ alloys: 3 }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ minerals: 6 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a metallurgist" do
      expect(subject.metallurgist?).to be_truthy
    end
  end

  describe "Job::CatalyticTechnician" do
    subject { Job::CatalyticTechnician }

    it "has the correct name" do
      expect(subject.name).to eq("Catalytic Technician")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ alloys: 3 }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ food: 9 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a metallurgist" do
      expect(subject.metallurgist?).to be_truthy
    end
  end

  describe "Job::Artisan" do
    subject { Job::Artisan }

    it "has the correct name" do
      expect(subject.name).to eq("Artisan")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ consumer_goods: 6 }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ minerals: 6 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an artisan" do
      expect(subject.artisan?).to be_truthy
    end
  end

  describe "Job::Artificer" do
    subject { Job::Artificer }

    it "has the correct name" do
      expect(subject.name).to eq("Artificer")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        consumer_goods: 7,
        trade: 2,
        engineering_research: 1.1,
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ minerals: 6 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an artisan" do
      expect(subject.artisan?).to be_truthy
    end
  end

  describe "Job::PearlDiver" do
    subject { Job::PearlDiver }

    it "has the correct name" do
      expect(subject.name).to eq("Pearl Diver")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        consumer_goods: 3,
        trade: 3,
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        food: 2,
        minerals: 2,
      }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an artisan" do
      expect(subject.artisan?).to be_truthy
    end
  end

  describe "Job::Chemist" do
    subject { Job::Chemist }

    it "has the correct name" do
      expect(subject.name).to eq("Chemist")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ volatile_motes: 2 }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ minerals: 10 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a chemist" do
      expect(subject.chemist?).to be_truthy
    end
  end

  describe "Job::GasRefiner" do
    subject { Job::GasRefiner }

    it "has the correct name" do
      expect(subject.name).to eq("Gas Refiner")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ exotic_gases: 2 }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ minerals: 10 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a refiner" do
      expect(subject.refiner?).to be_truthy
    end
  end

  describe "Job::Translucer" do
    subject { Job::Translucer }

    it "has the correct name" do
      expect(subject.name).to eq("Translucer")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ rare_crystals: 2 }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ minerals: 10 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a translucer" do
      expect(subject.translucer?).to be_truthy
    end
  end

  describe "Job::Colonist" do
    subject { Job::Colonist }

    it "has the correct name" do
      expect(subject.name).to eq("Colonist")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ food: 1 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(3)
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        defense_armies: { additive: 1 },
      }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end
  end

  describe "Job::Roboticist" do
    subject { Job::Roboticist }

    it "has the correct name" do
      expect(subject.name).to eq("Roboticist")
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        monthly_mechanical_pop_assembly: { additive: 2 },
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new(alloys: 2))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a pop assembler" do
      expect(subject.pop_assembler?).to be_truthy
    end
  end

  describe "Job::MedicalWorker" do
    subject { Job::MedicalWorker }

    it "has the correct name" do
      expect(subject.name).to eq("Medical Worker")
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(5)
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        pop_growth_speed_percent: { additive: 5 },
        organic_pop_assembly_speed_percent: { additive: 5 },
      }))
    end

    it "has the correct habitability modifier" do
      expect(subject.habitability_modifier).to eq(2.5)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 1 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a doctor" do
      expect(subject.doctor?).to be_truthy
    end
  end

  describe "Job::Entertainer" do
    subject { Job::Entertainer }

    it "has the correct name" do
      expect(subject.name).to eq("Entertainer")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ unity: 1 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(10)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 1 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an entertainer" do
      expect(subject.entertainer?).to be_truthy
    end
  end

  describe "Job::Duelist" do
    subject { Job::Duelist }

    it "has the correct name" do
      expect(subject.name).to eq("Duelist")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ unity: 2 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(10)
    end

    it "has the correct empire attribute modifiers" do
      expect(subject.empire_attribute_modifiers).to eq(ResourceModifier.new({
        naval_capacity: { additive: 2 },
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ alloys: 1 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an entertainer" do
      expect(subject.entertainer?).to be_truthy
    end
  end

  describe "Job::Enforcer" do
    subject { Job::Enforcer }

    it "has the correct name" do
      expect(subject.name).to eq("Enforcer")
    end

    it "has the correct stability modifier" do
      expect(subject.stability_modifier).to eq(1)
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        crime: { additive: -25 },
        defense_armies: { additive: 2 },
      }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an enforcer" do
      expect(subject.enforcer?).to be_truthy
    end
  end

  describe "Job::Telepath" do
    subject { Job::Telepath }

    it "has the correct name" do
      expect(subject.name).to eq("Telepath")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ unity: 6 }))
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        crime: { additive: -35 },
      }))
    end

    it "has the correct job output modifier" do
      expect(subject.all_job_output_modifiers(nil)).to eq(
        ResourceModifier::multiplyAllProducedResources(0.05)
      )
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 1 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end

    it "is a telepath" do
      expect(subject.telepath?).to be_truthy
    end
  end

  describe "Job::Necromancer" do
    subject { Job::Necromancer }

    it "has the correct name" do
      expect(subject.name).to eq("Necromancer")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        physics_research: 6,
        society_research: 6,
      }))
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        defense_armies: { additive: 3 },
      }))
    end

    it "has the correct empire attribute modifiers" do
      expect(subject.empire_attribute_modifiers).to eq(ResourceModifier.new({
        naval_capacity: { additive: 2 },
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        consumer_goods: 2,
      }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a researcher" do
      expect(subject.researcher?).to be_truthy
    end
  end

  describe "Job::Reassigner" do
    subject { Job::Reassigner }

    it "has the correct name" do
      expect(subject.name).to eq("Reassigner")
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        monthly_organic_pop_assembly: { additive: 2 },
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        consumer_goods: 2,
        food: 2,
      }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end
  end

  describe "Job::Necrophyte" do
    subject { Job::Necrophyte }

    it "has the correct name" do
      expect(subject.name).to eq("Necrophyte")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        unity: 1.5,
      }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(5)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        consumer_goods: 1,
        food: 1,
      }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a pop assembler" do
      expect(subject.pop_assembler?).to be_truthy
    end

    it "is a necro apprentice" do
      expect(subject.necro_apprentice?).to be_truthy
    end
  end

  describe "Job::Researcher" do
    subject { Job::Researcher }

    it "has the correct name" do
      expect(subject.name).to eq("Researcher")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        physics_research: 4,
        society_research: 4,
        engineering_research: 4,
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        consumer_goods: 2,
      }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a researcher" do
      expect(subject.researcher?).to be_truthy
    end
  end

  describe "Job::Bureaucrat" do
    subject { Job::Bureaucrat }

    it "has the correct name" do
      expect(subject.name).to eq("Bureaucrat")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ unity: 4 }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end
  end

  describe "Job::Manager" do
    subject { Job::Manager }

    it "has the correct name" do
      expect(subject.name).to eq("Manager")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        unity: 4,
        trade: 2,
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end

    it "is a manager" do
      expect(subject.manager?).to be_truthy
    end
  end

  describe "Job::Priest" do
    subject { Job::Priest }

    it "has the correct name" do
      expect(subject.name).to eq("Priest")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ unity: 4 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(2)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end

    it "is a priest" do
      expect(subject.priest?).to be_truthy
    end
  end

  describe "Job::DeathPriest" do
    subject { Job::DeathPriest }

    it "has the correct name" do
      expect(subject.name).to eq("Death Priest")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        unity: 3,
        society_research: 1,
      }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(2)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end

    it "is a priest" do
      expect(subject.priest?).to be_truthy
    end
  end

  describe "Job::Death Chronicler" do
    subject { Job::DeathChronicler }

    it "has the correct name" do
      expect(subject.name).to eq("Death Chronicler")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        unity: 2,
        society_research: 2,
      }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(2)
    end

    it "has the correct stability modifier" do
      expect(subject.stability_modifier).to eq(2)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end
  end

  describe "Job::CultureWorker" do
    subject { Job::CultureWorker }

    it "has the correct name" do
      expect(subject.name).to eq("Culture Worker")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        unity: 3,
        society_research: 3,
      }))
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ consumer_goods: 2 }))
    end

    it "is a specialist" do
      expect(subject.specialist?).to be_truthy
    end

    it "is a culture worker" do
      expect(subject.culture_worker?).to be_truthy
    end
  end
end

RSpec.describe "worker jobs" do
  describe "Job::Clerk" do
    subject { Job::Clerk }

    it "has the correct name" do
      expect(subject.name).to eq("Clerk")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ trade: 4 }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(2)
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end
  end

  describe "Job::Technician" do
    subject { Job::Technician }

    it "has the correct name" do
      expect(subject.name).to eq("Technician")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ energy: 6 }))
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a technician" do
      expect(subject.technician?).to be_truthy
    end
  end

  describe "Job::Miner" do
    subject { Job::Miner }

    it "has the correct name" do
      expect(subject.name).to eq("Miner")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ minerals: 4 }))
    end
    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a miner" do
      expect(subject.miner?).to be_truthy
    end
  end

  describe "Job::ScrapMiner" do
    subject { Job::ScrapMiner }

    it "has the correct name" do
      expect(subject.name).to eq("Scrap Miner")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        minerals: 2,
        alloys: 1,
      }))
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a miner" do
      expect(subject.miner?).to be_truthy
    end
  end

  describe "Job::Farmer" do
    subject { Job::Farmer }

    it "has the correct name" do
      expect(subject.name).to eq("Farmer")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ food: 6 }))
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a farmer" do
      expect(subject.farmer?).to be_truthy
    end
  end

  describe "Job::Angler" do
    subject { Job::Angler }

    it "has the correct name" do
      expect(subject.name).to eq("Angler")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        food: 8,
        trade: 2,
      }))
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a farmer" do
      expect(subject.farmer?).to be_truthy
    end
  end

  describe "Job::Soldier" do
    subject { Job::Soldier }

    it "has the correct name" do
      expect(subject.name).to eq("Soldier")
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        defense_armies: { additive: 3 },
      }))
    end

    it "has the correct empire attribute modifiers" do
      expect(subject.empire_attribute_modifiers).to eq(ResourceModifier.new({
        naval_capacity: { additive: 4 },
      }))
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a soldier" do
      expect(subject.soldier?).to be_truthy
    end
  end

  describe "Job::CrystalMiner" do
    subject { Job::CrystalMiner }

    it "has the correct name" do
      expect(subject.name).to eq("Crystal Miner")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ rare_crystals: 2 }))
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a miner" do
      expect(subject.miner?).to be_truthy
    end

    it "is a strategic resource miner" do
      expect(subject.strategic_resource_miner?).to be_truthy
    end
  end

  describe "Job::GasExtractor" do
    subject { Job::GasExtractor }

    it "has the correct name" do
      expect(subject.name).to eq("Gas Extractor")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ exotic_gases: 2 }))
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a miner" do
      expect(subject.miner?).to be_truthy
    end

    it "is a strategic resource miner" do
      expect(subject.strategic_resource_miner?).to be_truthy
    end
  end

  describe "Job::MoteHarvester" do
    subject { Job::MoteHarvester }

    it "has the correct name" do
      expect(subject.name).to eq("Mote Harvester")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ volatile_motes: 2 }))
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is a miner" do
      expect(subject.miner?).to be_truthy
    end

    it "is a strategic resource miner" do
      expect(subject.strategic_resource_miner?).to be_truthy
    end
  end

  describe "Job::MortalInitiate" do
    subject { Job::MortalInitiate }

    it "has the correct name" do
      expect(subject.name).to eq("Mortal Initiate")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        unity: 2,
        society_research: 1,
      }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(2)
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end
  end

  describe "Job::ProsperityPreacher" do
    subject { Job::ProsperityPreacher }

    it "has the correct name" do
      expect(subject.name).to eq("Prosperity Preacher")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        unity: 1,
        trade: 4,
      }))
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(3)
    end

    it "is a worker" do
      expect(subject.worker?).to be_truthy
    end

    it "is an administrator" do
      expect(subject.administrator?).to be_truthy
    end

    it "is a priest" do
      expect(subject.priest?).to be_truthy
    end
  end
end

RSpec.describe "slave jobs" do
  describe "Job::GridAmalgamated" do
    subject { Job::GridAmalgamated }

    it "has the correct name" do
      expect(subject.name).to eq("Grid Amalgamated")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ energy: 4 }))
    end

    it "has the correct housing modifier" do
      expect(subject.worker_housing_modifier).to eq(
        ResourceModifier.new({ housing: { additive: -0.5 } })
      )
    end

    it "is a slave" do
      expect(subject.slave?).to be_truthy
    end
  end

  describe "Job::Livestock" do
    subject { Job::Livestock }

    it "has the correct name" do
      expect(subject.name).to eq("Livestock")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ food: 4 }))
    end

    it "has the correct housing modifier" do
      expect(subject.worker_housing_modifier).to eq(
        ResourceModifier.new({ housing: { additive: -0.5 } })
      )
    end

    it "has the correct political power modifier" do
      expect(subject.worker_political_power_modifier).to eq(
        ResourceModifier.new({ political_power: { additive: -0.1 } })
      )
    end

    it "is a slave" do
      expect(subject.slave?).to be_truthy
    end
  end

  describe "Job::Servant" do
    subject { Job::Servant }

    it "has the correct name" do
      expect(subject.name).to eq("Servant")
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(4)
    end

    it "has the correct housing modifier" do
      expect(subject.worker_housing_modifier).to eq(
        ResourceModifier.new({ housing: { additive: -0.5 } })
      )
    end

    it "is a slave" do
      expect(subject.slave?).to be_truthy
    end
  end

  describe "Job::Overseer" do
    subject { Job::Overseer }

    it "has the correct name" do
      expect(subject.name).to eq("Overseer")
    end

    it "has the correct colony attribute modifiers" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        crime: { additive: -25 },
        defense_armies: { additive: 2 },
      }))
    end

    it "has the correct pop happiness modifier" do
      expect(subject.pop_happiness_modifiers).to eq(25)
    end

    it "is a slave" do
      expect(subject.slave?).to be_truthy
    end

    it "is an enforcer" do
      expect(subject.enforcer?).to be_truthy
    end
  end

  describe "Job::Toiler" do
    subject { Job::Toiler }

    it "has the correct name" do
      expect(subject.name).to eq("Toiler")
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(2)
    end

    it "is a slave" do
      expect(subject.slave?).to be_truthy
    end
  end

  describe "Job::AgriDrone" do
    subject { Job::AgriDrone }

    it "has the correct name" do
      expect(subject.name).to eq("Agri-Drone")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ food: 6 }))
    end

    it "is a menial drone" do
      expect(subject.menial_drone?).to be_truthy
    end

    it "is a farmer" do
      expect(subject.farmer?).to be_truthy
    end
  end

  describe "Job::TechDrone" do
    subject { Job::TechDrone }

    it "has the correct name" do
      expect(subject.name).to eq("Tech-Drone")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ energy: 6 }))
    end

    it "is a menial drone" do
      expect(subject.menial_drone?).to be_truthy
    end

    it "is a technician" do
      expect(subject.technician?).to be_truthy
    end
  end

  describe "Job::MiningDrone" do
    subject { Job::MiningDrone }

    it "has the correct name" do
      expect(subject.name).to eq("Mining Drone")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({ minerals: 4 }))
    end

    it "is a menial drone" do
      expect(subject.menial_drone?).to be_truthy
    end

    it "is a miner" do
      expect(subject.miner?).to be_truthy
    end
  end

  describe "Job::ScrapMinerDrone" do
    subject { Job::ScrapMinerDrone }

    it "has the correct name" do
      expect(subject.name).to eq("Scrap Miner Drone")
    end

    it "has the correct output" do
      expect(subject.output).to eq(ResourceGroup.new({
        minerals: 2,
        alloys: 1,
      }))
    end

    it "is a menial drone" do
      expect(subject.menial_drone?).to be_truthy
    end

    it "is a miner" do
      expect(subject.miner?).to be_truthy
    end
  end
end
