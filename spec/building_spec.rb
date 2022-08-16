require_relative "../stellaris/lib/stellaris"

RSpec.describe "buildings" do
  describe "defaults" do
    subject { Building.new(name: "") }

    it "provides no housing" do
      expect(subject.housing).to eq(0)
    end

    it "provides no amenities" do
      expect(subject.amenities_output).to eq(0)
    end

    it "provides no stability modifier" do
      expect(subject.stability_modifier).to eq(0)
    end

    it "has no colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({}))
    end

    it "provides no jobs" do
      expect(subject.max_jobs).to eq({})
    end

    it "has no  upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({}))
    end
  end

  describe "reassembled ship shelter" do
    subject { Building::ReassembledShipShelter }

    it "has the correct name" do
      expect(subject.name).to eq("Reassembled Ship Shelter")
    end

    it "provides the correct housing" do
      expect(subject.housing).to eq(3)
    end

    it "provides the correct amenities" do
      expect(subject.amenities_output).to eq(7)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 1 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Colonist => 2,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 1 }))
    end
  end

  describe "planetary administration" do
    subject { Building::PlanetaryAdministration }

    it "has the correct name" do
      expect(subject.name).to eq("Planetary Administration")
    end

    it "provides the correct housing" do
      expect(subject.housing).to eq(5)
    end

    it "provides the correct amenities" do
      expect(subject.amenities_output).to eq(5)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 2 },
        branch_office_building_slot: { additive: 1 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 2,
        Job::Enforcer => 1,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 5 }))
    end
  end

  describe "planetary capital" do
    subject { Building::PlanetaryCapital }

    it "has the correct name" do
      expect(subject.name).to eq("Planetary Capital")
    end

    it "provides the correct housing" do
      expect(subject.housing).to eq(8)
    end

    it "provides the correct amenities" do
      expect(subject.amenities_output).to eq(8)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 3 },
        branch_office_building_slot: { additive: 2 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 3,
        Job::Enforcer => 2,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 8 }))
    end
  end

  describe "system capital-complex" do
    subject { Building::SystemCapitalComplex }

    it "has the correct name" do
      expect(subject.name).to eq("System Capital-Complex")
    end

    it "provides the correct housing" do
      expect(subject.housing).to eq(12)
    end

    it "provides the correct amenities" do
      expect(subject.amenities_output).to eq(12)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 4 },
        branch_office_building_slot: { additive: 4 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 4,
        Job::Enforcer => 3,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 10 }))
    end
  end

  describe "imperial palace" do
    subject { Building::ImperialPalace }

    it "has the correct name" do
      expect(subject.name).to eq("Imperial Palace")
    end

    it "provides the correct housing" do
      expect(subject.housing).to eq(18)
    end

    it "provides the correct amenities" do
      expect(subject.amenities_output).to eq(18)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 11 },
        branch_office_building_slot: { additive: 4 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 6,
        Job::Enforcer => 5,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 10 }))
    end
  end

  describe "habitat administration" do
    subject { Building::HabitatAdministration }

    it "has the correct name" do
      expect(subject.name).to eq("Habitat Administration")
    end

    it "provides the correct housing" do
      expect(subject.housing).to eq(3)
    end

    it "provides the correct amenities" do
      expect(subject.amenities_output).to eq(3)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 1 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 1,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 3,
        alloys: 5,
      }))
    end
  end

  describe "habitat central control" do
    subject { Building::HabitatCentralControl }

    it "has the correct name" do
      expect(subject.name).to eq("Habitat Central Control")
    end

    it "provides the correct housing" do
      expect(subject.housing).to eq(5)
    end

    it "provides the correct amenities" do
      expect(subject.amenities_output).to eq(5)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 2 },
        branch_office_building_slot: { additive: 1 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 2,
        Job::Enforcer => 1,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 3,
        alloys: 5,
      }))
    end
  end

  describe "resort administration" do
    subject { Building::ResortAdministration }

    it "has the correct name" do
      expect(subject.name).to eq("Resort Administration")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(5)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(5)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 5 },
        branch_office_building_slot: { additive: 1 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 1,
        Job::Entertainer => 1,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe "resort capital-complex" do
    subject { Building::ResortCapitalComplex }

    it "has the correct name" do
      expect(subject.name).to eq("Resort Capital-Complex")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(10)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(10)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 11 },
        branch_office_building_slot: { additive: 2 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 1,
        Job::Entertainer => 2,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 5}))
    end
  end

  describe "governor's palace" do
    subject { Building::GovernorsPalace }

    it "has the correct name" do
      expect(subject.name).to eq("Governor's Palace")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(5)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(5)
    end

    it "has the correct stability modifier" do
      expect(subject.stability_modifier).to eq(5)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 5 },
        branch_office_building_slot: { additive: 1 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 2,
        Job::Overseer => 2,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe "governor's estates" do
    subject { Building::GovernorsEstates }

    it "has the correct name" do
      expect(subject.name).to eq("Governor's Estates")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(10)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(10)
    end

    it "has the correct stability modifier" do
      expect(subject.stability_modifier).to eq(10)
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        building_slot: { additive: 11 },
        branch_office_building_slot: { additive: 2 },
      }))
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({
        Job::Politician => 2,
        Job::Overseer => 4,
      })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'research labs' do
    subject { Building::ResearchLabs }

    it "has the correct name" do
      expect(subject.name).to eq("Research Labs")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Researcher => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'research complexes' do
    subject { Building::ResearchComplexes }

    it "has the correct name" do
      expect(subject.name).to eq("Research Complexes")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Researcher => 4 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 5,
        exotic_gases: 1,
      }))
    end
  end

  describe 'advanced research complexes' do
    subject { Building::AdvancedResearchComplexes }

    it "has the correct name" do
      expect(subject.name).to eq("Advanced Research Complexes")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Researcher => 6 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 8,
        exotic_gases: 2,
      }))
    end
  end

  describe 'administrative offices' do
    subject { Building::AdministrativeOffices }

    it "has the correct name" do
      expect(subject.name).to eq("Administrative Offices")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Bureaucrat => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'administrative park' do
    subject { Building::AdministrativePark }

    it "has the correct name" do
      expect(subject.name).to eq("Administrative Park")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Bureaucrat => 4 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 5,
        rare_crystals: 1,
      }))
    end
  end

  describe 'administrative complex' do
    subject { Building::AdministrativeComplex }

    it "has the correct name" do
      expect(subject.name).to eq("Administrative Complex")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Bureaucrat => 6 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 8,
        rare_crystals: 2,
      }))
    end
  end

  describe 'holo-theatres' do
    subject { Building::HoloTheatres }

    it "has the correct name" do
      expect(subject.name).to eq("Holo-Theatres")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Entertainer => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'hyper-entertainment forums' do
    subject { Building::HyperEntertainmentForums }

    it "has the correct name" do
      expect(subject.name).to eq("Hyper-Entertainment Forums")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Entertainer => 4 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 5,
        exotic_gases: 1,
      }))
    end
  end

  describe 'hydroponics farms' do
    subject { Building::HydroponicsFarms }

    it "has the correct name" do
      expect(subject.name).to eq("Hydroponics Farms")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Farmer => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'luxury residences' do
    subject { Building::LuxuryResidences }

    it "has the correct name" do
      expect(subject.name).to eq("Luxury Residences")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(3)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(5)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'paradise dome' do
    subject { Building::ParadiseDome }

    it "has the correct name" do
      expect(subject.name).to eq("Paradise Dome")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(6)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(10)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 5,
        rare_crystals: 1,
      }))
    end
  end

  describe 'communal housing' do
    subject { Building::CommunalHousing }

    it "has the correct name" do
      expect(subject.name).to eq("Communal Housing")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(5)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(3)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'utopian communal housing' do
    subject { Building::UtopianCommunalHousing }

    it "has the correct name" do
      expect(subject.name).to eq("Utopian Communal Housing")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(10)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(6)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 5,
        rare_crystals: 1,
      }))
    end
  end

  describe 'slave huts' do
    subject { Building::SlaveHuts }

    it "has the correct name" do
      expect(subject.name).to eq("Slave Huts")
    end

    it "has the correct housing" do
      expect(subject.housing).to eq(8)
    end

    it "has the correct amenities output" do
      expect(subject.amenities_output).to eq(0)
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'planetary shield generator' do
    subject { Building::PlanetaryShieldGenerator }

    it "has the correct name" do
      expect(subject.name).to eq("Planetary Shield Generator")
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 5}))
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        orbital_bombardment_damage_multiplier: { additive: -0.5 },
      }))
    end
  end

  describe 'military academy' do
    subject { Building::MilitaryAcademy }

    it "has the correct name" do
      expect(subject.name).to eq("Military Academy")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Soldier => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        army_starting_experience: { additive: 100 },
      }))
    end
  end

  describe 'dreaed encampment' do
    subject { Building::DreadEncampment }

    it "has the correct name" do
      expect(subject.name).to eq("Dread Encampment")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Necromancer => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end

    it "has the correct colony attribute modifier" do
      expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
        army_starting_experience: { additive: 100 },
      }))
    end
  end

  describe 'chamber of elevation' do
    subject { Building::ChamberOfElevation }

    it "has the correct name" do
      expect(subject.name).to eq("Chamber of Elevation")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Necrophyte => 1 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
    end
  end

  describe 'house of apotheosis' do
    subject { Building::HouseOfApotheosis }

    it "has the correct name" do
      expect(subject.name).to eq("House of Apotheosis")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Necrophyte => 6 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 5,
        exotic_gases: 1,
      }))
    end
  end

  describe 'energy grid' do
    subject { Building::EnergyGrid }

    it "has the correct name" do
      expect(subject.name).to eq("Energy Grid")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Technician => 1 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 2 }))
    end

    it "has no default job output modifier" do
      expect(subject.job_output_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has the correct job output modifier for technician jobs" do
      pop_job = PopJob.new(
        job: Job::Technician,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ energy: { additive: 1 } })
      )
    end

    it "has the correct job output modifier for technician category jobs" do
      job = instance_double("Job")

      expect(job).to receive(:technician?).and_return(true)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ energy: { additive: 1 } })
      )
    end
  end

  describe 'energy nexus' do
    subject { Building::EnergyNexus }

    it "has the correct name" do
      expect(subject.name).to eq("Energy Nexus")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Technician => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 2,
        exotic_gases: 1,
      }))
    end

    it "has no default job output modifier" do
      expect(subject.job_output_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has the correct job output modifier for technician jobs" do
      pop_job = PopJob.new(
        job: Job::Technician,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ energy: { additive: 2 } })
      )
    end

    it "has the correct job output modifier for technician category jobs" do
      job = instance_double("Job")

      expect(job).to receive(:technician?).and_return(true)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ energy: { additive: 2 } })
      )
    end
  end

  describe 'mineral purification plants' do
    subject { Building::MineralPurificationPlants }

    it "has the correct name" do
      expect(subject.name).to eq("Mineral Purification Plants")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Miner => 1 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 2 }))
    end

    it "has no default job output modifier" do
      expect(subject.job_output_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has the correct job output modifier for miner jobs" do
      pop_job = PopJob.new(
        job: Job::Miner,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ minerals: { additive: 1 } })
      )
    end

    it "has the correct job output modifier for miner category jobs" do
      job = instance_double("Job")

      expect(job).to receive(:miner?).and_return(true)
      expect(job).to receive(:strategic_resource_miner?).and_return(false)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ minerals: { additive: 1 } })
      )
    end

    it "has no job output modifier for strategic resource miners" do
      job = instance_double("Job")

      expect(job).to receive(:miner?).and_return(true)
      expect(job).to receive(:strategic_resource_miner?).and_return(true)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(ResourceModifier::NONE);
    end
  end

  describe 'mineral purification hubs' do
    subject { Building::MineralPurificationHubs }

    it "has the correct name" do
      expect(subject.name).to eq("Mineral Purification Hubs")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Miner => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 2,
        volatile_motes: 1,
      }))
    end

    it "has no default job output modifier" do
      expect(subject.job_output_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has the correct job output modifier for miner jobs" do
      pop_job = PopJob.new(
        job: Job::Miner,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ minerals: { additive: 2 } })
      )
    end

    it "has the correct job output modifier for miner category jobs" do
      job = instance_double("Job")

      expect(job).to receive(:miner?).and_return(true)
      expect(job).to receive(:strategic_resource_miner?).and_return(false)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ minerals: { additive: 2 } })
      )
    end

    it "has the correct job output modifier for Scrap Miner jobs" do
      pop_job = PopJob.new(
        job: Job::ScrapMiner,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({
          minerals: { additive: 1 },
          alloys: { additive: 0.5 },
        })
      )
    end

    it "has no job output modifier for strategic resource miners" do
      job = instance_double("Job")

      expect(job).to receive(:miner?).and_return(true)
      expect(job).to receive(:strategic_resource_miner?).and_return(true)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(ResourceModifier::NONE);
    end
  end

  describe 'food processing facilities' do
    subject { Building::FoodProcessingFacilities }

    it "has the correct name" do
      expect(subject.name).to eq("Food Processing Facilities")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Farmer => 1 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({ energy: 2 }))
    end

    it "has no default job output modifier" do
      expect(subject.job_output_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has the correct job output modifier for farmer jobs" do
      pop_job = PopJob.new(
        job: Job::Farmer,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ food: { additive: 1 } })
      )
    end

    it "has the correct job output modifier for farmer category jobs" do
      job = instance_double("Job")

      expect(job).to receive(:farmer?).and_return(true)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ food: { additive: 1 } })
      )
    end
  end

  describe 'food processing centers' do
    subject { Building::FoodProcessingCenters }

    it "has the correct name" do
      expect(subject.name).to eq("Food Processing Centers")
    end

    it "has the correct max jobs" do
      expect(subject.max_jobs).to eq({ Job::Farmer => 2 })
    end

    it "has the correct upkeep" do
      expect(subject.upkeep).to eq(ResourceGroup.new({
        energy: 2,
        volatile_motes: 1,
      }))
    end

    it "has no default job output modifier" do
      expect(subject.job_output_modifiers(nil)).to eq(ResourceModifier::NONE)
    end

    it "has the correct job output modifier for farmer jobs" do
      pop_job = PopJob.new(
        job: Job::Farmer,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ food: { additive: 2 } })
      )
    end

    it "has the correct job output modifier for farmer category jobs" do
      job = instance_double("Job")

      expect(job).to receive(:farmer?).and_return(true)

      pop_job = PopJob.new(
        job: job,
        worker: nil,
      )

      expect(subject.job_output_modifiers(pop_job)).to eq(
        ResourceModifier.new({ food: { additive: 2 } })
      )
    end
  end
end
