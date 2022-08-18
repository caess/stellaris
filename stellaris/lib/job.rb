require_relative "./resource_group"
require_relative "./resource_modifier"

class Job
  attr_reader :name, :amenities_output,
    :stability_modifier, :habitability_modifier,
    :colony_attribute_modifiers, :empire_attribute_modifiers,
    :worker_housing_modifier, :pop_happiness_modifiers,
    :worker_political_power_modifier

  def initialize(
    name:, strata: :none, category: :none, subcategory: :none, output: {},
    upkeep: {}, amenities_output: 0, stability_modifier: 0,
    colony_attribute_modifiers: {}, habitability_modifier: 0,
    empire_attribute_modifiers: {}, all_job_output_modifiers: {},
    worker_housing_modifier: {}, worker_political_power_modifier: {},
    pop_happiness_modifiers: 0
  )
    @name = name
    @strata = strata
    @category = category
    @subcategory = subcategory
    @output = ResourceGroup.new(output)
    @upkeep = ResourceGroup.new(upkeep)
    @amenities_output = amenities_output
    @stability_modifier = stability_modifier
    @colony_attribute_modifiers = ResourceModifier.new(colony_attribute_modifiers)
    @empire_attribute_modifiers = ResourceModifier.new(empire_attribute_modifiers)
    @all_job_output_modifiers = ResourceModifier.new(all_job_output_modifiers)
    @worker_housing_modifier = ResourceModifier.new(worker_housing_modifier)
    @habitability_modifier = habitability_modifier
    @pop_happiness_modifiers = pop_happiness_modifiers
    @worker_political_power_modifier = ResourceModifier.new(worker_political_power_modifier)
  end

  def output
    @output.dup
  end

  def upkeep
    @upkeep.dup
  end

  def all_job_output_modifiers(job)
    @all_job_output_modifiers
  end

  # Strata
  def ruler?
    @strata == :ruler
  end

  def specialist?
    @strata == :specialist
  end

  def worker?
    @strata == :worker
  end

  def slave?
    @strata == :slave
  end

  def complex_drone?
    @strata == :complex_drone
  end

  def menial_drone?
    @strata == :menial_drone
  end

  # Categories
  def farmer?
    @category == :farmers
  end

  def miner?
    @category == :miners
  end

  def strategic_resource_miner?
    miner? and @subcategory == :strategic_resource_miners
  end

  def livestock?
    @category == :livestock
  end

  def technician?
    @category == :technicians
  end

  def politician?
    @category == :politicians
  end

  def executive?
    politician? and @subcategory == :executives
  end

  def noble?
    politician? and @subcategory == :nobles
  end

  def administrator?
    @category == :administrators
  end

  def manager?
    administrator? and @subcategory == :managers
  end

  def priest?
    administrator? and @subcategory == :priests
  end

  def telepath?
    administrator? and @subcategory == :telepaths
  end

  def researcher?
    @category == :researchers
  end

  def metallurgist?
    @category == :metallurgists
  end

  def culture_worker?
    @category == :culture_workers
  end

  def evaluator?
    @category == :evaluators
  end

  def refiner?
    @category == :refiners
  end

  def translucer?
    @category == :translucers
  end

  def chemist?
    @category == :chemists
  end

  def artisan?
    @category == :artisans
  end

  def bio_trophy?
    @category == :bio_trophies
  end

  def pop_assembler?
    @category == :pop_assemblers
  end

  def necro_apprentice?
    pop_assembler? and @subcategory == :necro_apprentices
  end

  def merchant?
    @category == :merchants
  end

  def entertainer?
    @category == :entertainers
  end

  def soldier?
    @category == :soldiers
  end

  def enforcer?
    @category == :enforcers
  end

  def doctor?
    @category == :doctors
  end

  # ruler jobs
  Politician = Job.new(
    name: "Politician",
    strata: :ruler,
    category: :politicians,
    output: { unity: 6 },
    amenities_output: 3,
    upkeep: { consumer_goods: 2 },
  )

  Executive = Job.new(
    name: "Executive",
    strata: :ruler,
    category: :politicians,
    subcategory: :executives,
    output: {
      unity: 6,
      trade: 4,
    },
    amenities_output: 3,
    upkeep: { consumer_goods: 2 },
  )

  Merchant = Job.new(
    name: "Merchant",
    strata: :ruler,
    category: :merchants,
    output: { trade: 12 },
    amenities_output: 3,
    upkeep: { consumer_goods: 2 },
  )

  ScienceDirector = Job.new(
    name: "Science Director",
    strata: :ruler,
    category: :researchers,
    output: {
      physics_research: 6,
      society_research: 6,
      engineering_research: 6,
      unity: 2,
    },
    amenities_output: 3,
    upkeep: { consumer_goods: 2 },
  )

  HighPriest = Job.new(
    name: "High Priest",
    strata: :ruler,
    category: :administrators,
    subcategory: :priests,
    output: { unity: 6 },
    amenities_output: 5,
    upkeep: { consumer_goods: 2 },
  )

  Noble = Job.new(
    name: "Noble",
    strata: :ruler,
    category: :politicians,
    subcategory: :nobles,
    output: { unity: 6 },
    amenities_output: 3,
    stability_modifier: 2,
    upkeep: { consumer_goods: 2 },
  )

  # specialist jobs
  Metallurgist = Job.new(
    name: "Metallurgist",
    strata: :specialist,
    category: :metallurgists,
    output: { alloys: 3 },
    upkeep: { minerals: 6 },
  )

  CatalyticTechnician = Job.new(
    name: "Catalytic Technician",
    strata: :specialist,
    category: :metallurgists,
    output: { alloys: 3 },
    upkeep: { food: 9 },
  )

  Artisan = Job.new(
    name: "Artisan",
    strata: :specialist,
    category: :artisans,
    output: { consumer_goods: 6 },
    upkeep: { minerals: 6 },
  )

  Artificer = Job.new(
    name: "Artificer",
    strata: :specialist,
    category: :artisans,
    output: {
      consumer_goods: 7,
      trade: 2,
      engineering_research: 1.1,
    },
    upkeep: { minerals: 6 },
  )

  PearlDiver = Job.new(
    name: "Pearl Diver",
    strata: :specialist,
    category: :artisans,
    output: {
      consumer_goods: 3,
      trade: 3,
    },
    upkeep: {
      food: 2,
      minerals: 2,
    },
  )

  Chemist = Job.new(
    name: "Chemist",
    strata: :specialist,
    category: :chemists,
    output: { volatile_motes: 2 },
    upkeep: { minerals: 10 },
  )

  GasRefiner = Job.new(
    name: "Gas Refiner",
    strata: :specialist,
    category: :refiners,
    output: { exotic_gases: 2 },
    upkeep: { minerals: 10 },
  )

  Translucer = Job.new(
    name: "Translucer",
    strata: :specialist,
    category: :translucers,
    output: { rare_crystals: 2 },
    upkeep: { minerals: 10 },
  )

  Colonist = Job.new(
    name: "Colonist",
    strata: :specialist,
    output: { food: 1 },
    amenities_output: 3,
    colony_attribute_modifiers: {
      defense_armies: { additive: 1 },
    },
  )

  Roboticist = Job.new(
    name: "Roboticist",
    strata: :specialist,
    category: :pop_assemblers,
    colony_attribute_modifiers: {
      monthly_mechanical_pop_assembly: { additive: 2 },
    },
    upkeep: { alloys: 2 },
  )

  MedicalWorker = Job.new(
    name: "Medical Worker",
    strata: :specialist,
    category: :doctors,
    amenities_output: 5,
    colony_attribute_modifiers: {
      pop_growth_speed_percent: { additive: 5 },
      organic_pop_assembly_speed_percent: { additive: 5 },
    },
    habitability_modifier: 2.5,
    upkeep: { consumer_goods: 1 },
  )

  Entertainer = Job.new(
    name: "Entertainer",
    strata: :specialist,
    category: :entertainers,
    output: { unity: 1 },
    amenities_output: 10,
    upkeep: { consumer_goods: 1 },
  )

  Duelist = Job.new(
    name: "Duelist",
    strata: :specialist,
    category: :entertainers,
    output: { unity: 2 },
    amenities_output: 10,
    empire_attribute_modifiers: { naval_capacity: { additive: 2 } },
    upkeep: { alloys: 1 },
  )

  Enforcer = Job.new(
    name: "Enforcer",
    strata: :specialist,
    category: :enforcers,
    stability_modifier: 1,
    colony_attribute_modifiers: {
      crime: { additive: -25 },
      defense_armies: { additive: 2 },
    },
  )

  Telepath = Job.new(
    name: "Telepath",
    strata: :specialist,
    category: :administrators,
    subcategory: :telepaths,
    output: { unity: 6 },
    colony_attribute_modifiers: { crime: { additive: -35 } },
    all_job_output_modifiers: ResourceModifier::multiplyAllProducedResources(0.05),
    upkeep: { energy: 1 },
  )

  Necromancer = Job.new(
    name: "Necromancer",
    strata: :specialist,
    category: :researchers,
    output: {
      physics_research: 6,
      society_research: 6,
    },
    colony_attribute_modifiers: { defense_armies: { additive: 3 } },
    empire_attribute_modifiers: { naval_capacity: { additive: 2 } },
    upkeep: { consumer_goods: 2 },
  )

  Reassigner = Job.new(
    name: "Reassigner",
    strata: :specialist,
    colony_attribute_modifiers: {
      monthly_organic_pop_assembly: { additive: 2 },
    },
    upkeep: {
      consumer_goods: 2,
      food: 2,
    },
  )

  Necrophyte = Job.new(
    name: "Necrophyte",
    strata: :specialist,
    category: :pop_assemblers,
    subcategory: :necro_apprentices,
    output: { unity: 1.5 },
    amenities_output: 5,
    upkeep: {
      consumer_goods: 1,
      food: 1,
    },
  )

  Researcher = Job.new(
    name: "Researcher",
    strata: :specialist,
    category: :researchers,
    output: {
      physics_research: 4,
      society_research: 4,
      engineering_research: 4,
    },
    upkeep: { consumer_goods: 2 },
  )

  Bureaucrat = Job.new(
    name: "Bureaucrat",
    strata: :specialist,
    category: :administrators,
    output: { unity: 4 },
    upkeep: { consumer_goods: 2 },
  )

  Manager = Job.new(
    name: "Manager",
    strata: :specialist,
    category: :administrators,
    subcategory: :managers,
    output: {
      unity: 4,
      trade: 2,
    },
    upkeep: { consumer_goods: 2 },
  )

  Priest = Job.new(
    name: "Priest",
    strata: :specialist,
    category: :administrators,
    subcategory: :priests,
    output: { unity: 4 },
    amenities_output: 2,
    upkeep: { consumer_goods: 2 },
  )

  DeathPriest = Job.new(
    name: "Death Priest",
    strata: :specialist,
    category: :administrators,
    subcategory: :priests,
    output: {
      unity: 3,
      society_research: 1,
    },
    amenities_output: 2,
    upkeep: { consumer_goods: 2 },
  )

  DeathChronicler = Job.new(
    name: "Death Chronicler",
    strata: :specialist,
    category: :administrators,
    output: {
      unity: 2,
      society_research: 2,
    },
    amenities_output: 2,
    stability_modifier: 2,
    upkeep: { consumer_goods: 2 },
  )

  CultureWorker = Job.new(
    name: "Culture Worker",
    strata: :specialist,
    category: :culture_workers,
    output: {
      unity: 3,
      society_research: 3,
    },
    upkeep: { consumer_goods: 2 },
  )

  # Worker jobs
  Clerk = Job.new(
    name: "Clerk",
    strata: :worker,
    output: { trade: 4 },
    amenities_output: 2,
  )

  Technician = Job.new(
    name: "Technician",
    strata: :worker,
    category: :technicians,
    output: { energy: 6 },
  )

  Miner = Job.new(
    name: "Miner",
    strata: :worker,
    category: :miners,
    output: { minerals: 4 },
  )

  ScrapMiner = Job.new(
    name: "Scrap Miner",
    strata: :worker,
    category: :miners,
    output: {
      minerals: 2,
      alloys: 1,
    },
  )

  Farmer = Job.new(
    name: "Farmer",
    strata: :worker,
    category: :farmers,
    output: { food: 6 },
  )

  Angler = Job.new(
    name: "Angler",
    strata: :worker,
    category: :farmers,
    output: {
      food: 8,
      trade: 2,
    },
  )

  Soldier = Job.new(
    name: "Soldier",
    strata: :worker,
    category: :soldiers,
    colony_attribute_modifiers: {
      defense_armies: { additive: 3 },
    },
    empire_attribute_modifiers: {
      naval_capacity: { additive: 4 },
    },
  )

  CrystalMiner = Job.new(
    name: "Crystal Miner",
    strata: :worker,
    category: :miners,
    subcategory: :strategic_resource_miners,
    output: { rare_crystals: 2 },
  )

  GasExtractor = Job.new(
    name: "Gas Extractor",
    strata: :worker,
    category: :miners,
    subcategory: :strategic_resource_miners,
    output: { exotic_gases: 2 },
  )

  MoteHarvester = Job.new(
    name: "Mote Harvester",
    strata: :worker,
    category: :miners,
    subcategory: :strategic_resource_miners,
    output: { volatile_motes: 2 },
  )

  MortalInitiate = Job.new(
    name: "Mortal Initiate",
    strata: :worker,
    category: :administrators,
    output: {
      unity: 2,
      society_research: 1,
    },
    amenities_output: 2,
  )

  ProsperityPreacher = Job.new(
    name: "Prosperity Preacher",
    strata: :worker,
    category: :administrators,
    subcategory: :priests,
    output: {
      unity: 1,
      trade: 4,
    },
    amenities_output: 3,
  )

  # slave jobs
  GridAmalgamated = Job.new(
    name: "Grid Amalgamated",
    strata: :slave,
    output: { energy: 4 },
    worker_housing_modifier: { housing: { additive: -0.5 } },
  )

  Livestock = Job.new(
    name: "Livestock",
    strata: :slave,
    output: { food: 4 },
    worker_housing_modifier: { housing: { additive: -0.5 } },
    worker_political_power_modifier: { political_power: { additive: -0.1 } },
  )

  Servant = Job.new(
    name: "Servant",
    strata: :slave,
    amenities_output: 4,
    worker_housing_modifier: { housing: { additive: -0.5 } },
  )

  Overseer = Job.new(
    name: "Overseer",
    strata: :slave,
    category: :enforcers,
    colony_attribute_modifiers: {
      crime: { additive: -25 },
      defense_armies: { additive: 2 },
    },
    pop_happiness_modifiers: 25,
  )

  Toiler = Job.new(
    name: "Toiler",
    strata: :slave,
    amenities_output: 2,
  )

  # Menial drone jobs
  AgriDrone = Job.new(
    name: "Agri-Drone",
    strata: :menial_drone,
    category: :farmers,
    output: { food: 6 },
  )

  TechDrone = Job.new(
    name: "Tech-Drone",
    strata: :menial_drone,
    category: :technicians,
    output: { energy: 6 },
  )

  MiningDrone = Job.new(
    name: "Mining Drone",
    strata: :menial_drone,
    category: :miners,
    output: { minerals: 4 },
  )

  def self.lookup(name)
    if name.is_a?(Job)
      return name
    elsif name.is_a?(Symbol)
      self::const_get(name.to_s.split("_").map(&:capitalize).join("").to_sym)
    else
      self.constants.find { |x| x.is_a?(Job) and x.name == name }
    end
  end
end
