# frozen_string_literal: true

require_relative './district'
require_relative './job'
require_relative './mixins'
require_relative './pop'
require_relative './resource_group'
require_relative './resource_modifier'

class Colony
  include OutputsResources
  include UsesAmenities

  attr_reader :pops, :districts

  def initialize(
    type:, size:, sector:, designation: nil, districts: {}, buildings: {},
    decisions: {}, jobs: {}, deposits: {}, fill_jobs_with: nil
  )
    @type = type
    @size = size
    @sector = sector
    @sector.add_colony(self)
    @designation = designation
    @districts = districts.dup
    @buildings = buildings.dup
    @decisions = decisions.dup

    @districts = []
    districts.each do |type, number|
      case type
      when :habitation
        district = District::HabitationDistrict
      when :industrial
        district = District::HabitatIndustrialDistrict
      when :mining
        district = District::AstroMiningBay
      when :reactor
        district = District::ReactorDistrict
      when :research
        district = District::ResearchDistrict
      when :trade
        district = District::HabitatTradeDistrict
      when :leisure
        district = District::LeisureDistrict
      end

      1.upto(number) { |_x| @districts << district }
    end

    deposits = [deposits] unless deposits.is_a?(Array)
    @deposits = deposits.map do |deposit|
      case deposit
      when Hash
        ResourceGroup.new(deposit)
      when ResourceGroup
        deposit
      end
    end

    @pops = []
    if fill_jobs_with
      @jobs = max_jobs

      @jobs.each do |job_id, num|
        job = Job.lookup(job_id)

        1.upto(num) do |_x|
          @pops << Pop.new(species: fill_jobs_with, colony: self, job: job)
        end
      end
    else
      jobs.each do |job_id, pops|
        job = Job.lookup(job_id)

        pops.each do |species, count|
          1.upto(count) do
            @pops << Pop.new(species: species, colony: self, job: job)
          end
        end
      end
    end

    @num_pops = @pops.length
    @attributes = nil
  end

  def add_pop(pop)
    @pops << pop
    @attributes = nil
  end

  def buildings(type)
    (@buildings[type] || 0)
  end

  def num_districts(type)
    @districts.find_all { |d| d == type }.count
  end

  def jobs(job)
    @pops.filter { |pop| pop.has_job?(job) }.count
  end

  def all_jobs
    @jobs
  end

  def max_jobs
    max_jobs = @districts.reduce({}) { |sum, x| sum.merge(x.max_jobs) { |_k, v1, v2| v1 + v2 } }
    max_jobs = max_jobs.merge({
                                Job::Politician => 2 * buildings(:habitat_central_control),
                                Job::Enforcer => 1 * buildings(:habitat_central_control),
                                Job::Artisan => 2 * buildings(:civilian_industries),
                                Job::Metallurgist => 2 * buildings(:alloy_foundries),
                                Job::Colonist => 2 * buildings(:habitat_administration),
                                Job::Researcher => 2 * buildings(:research_labs),
                                Job::Bureaucrat => 2 * buildings(:administrative_offices),
                                Job::Entertainer => 2 * buildings(:holo_theatres),
                                Job::Farmer => 3 * buildings(:hydroponics_farms)
                              }) { |_k, v1, v2| v1 + v2 }

    case @designation
    when :factory_station
      max_jobs[Job::Artisan] += 1 * num_districts(District::HabitatIndustrialDistrict)
      max_jobs[Job::Metallurgist] -= 1 * num_districts(District::HabitatIndustrialDistrict)
    when :foundry_station
      max_jobs[Job::Artisan] -= 1 * num_districts(District::HabitatIndustrialDistrict)
      max_jobs[Job::Metallurgist] += 1 * num_districts(District::HabitatIndustrialDistrict)
    when :hydroponics_station
      max_jobs[Job::Farmer] += 1 * num_districts(District::HabitationDistrict)
    end

    max_jobs
  end

  def buildings_amenities_output
    (5 * buildings(:habitat_central_control)) +
      (3 * buildings(:habitat_administration))
  end

  def designation_amenities_output
    @designation == :empire_capital ? 10 : 0
  end

  def amenities_output
    buildings_amenities_output + designation_amenities_output +
      @pops.reduce(0) { |sum, pop| sum + pop.amenities_output }
  end

  def amenities_upkeep
    5 + @pops.reduce(0) { |sum, pop| sum + pop.amenities_upkeep }
  end

  def pop_happiness_modifiers
    modifier = 0
    modifier += 10 if @designation == :leisure_station
    modifier += @pops.reduce(0) { |sum, pop| sum + pop.pop_happiness_modifiers }

    if net_amenities.positive?
      modifier += [20, (20.0 * net_amenities / amenities_upkeep)].min
    elsif net_amenities.negative?
      modifier += [-50, 100 * (2.0 / 3 * net_amenities / amenities_upkeep)].max
    end

    modifier
  end

  def approval_rating
    1.0 * @pops.reduce(0) do |sum, pop|
      sum + (pop.happiness * pop.political_power)
    end / @pops.reduce(0) { |sum, pop| sum + pop.political_power }
  end

  def stability_modifier
    @designation == :empire_capital ? 5 : 0
  end

  def stability
    stability = [
      50,
      @pops.reduce(0) { |sum, pop| sum + pop.stability_modifier },
      @sector.stability_modifier,
      stability_modifier
    ].reduce(0, &:+)

    if approval_rating > 50
      stability += (0.6 * (approval_rating - 50)).floor
    elsif approval_rating < 50
      stability -= (50 - approval_rating).floor
    end

    stability
  end

  def stability_coefficient
    if stability > 50
      0.006 * (stability - 50).floor
    elsif stability < 50
      -0.01 * (50 - stability).floor
    else
      0
    end
  end

  def stability_coefficient_modifier
    ResourceModifier::MultiplyAllProducedResources.new(stability_coefficient) +
      ResourceModifier.new(trade: { multiplicative: stability_coefficient })
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new

    @pops.each { |pop| modifier += pop.all_job_output_modifiers(job) }

    modifier += stability_coefficient_modifier
    modifier += @sector.job_output_modifiers(job)

    @decisions.each { |d| modifier += d.job_output_modifiers(job) }

    case @designation
    when :empire_capital
      modifier += ResourceModifier::MultiplyAllProducedResources.new(0.1)
    when :research_station
      modifier += ResourceModifier.new({
                                         physics_research: { multiplicative: 0.1 },
                                         society_research: { multiplicative: 0.1 },
                                         engineering_research: { multiplicative: 0.1 }
                                       })
    when :refinery_station
      if job.chemist? || job.translucer? || job.refiner?
        modifier += ResourceModifier.new({
                                           exotic_gases: { multiplicative: 0.1 },
                                           rare_crystals: { multiplicative: 0.1 },
                                           volatile_motes: { multiplicative: 0.1 }
                                         })
      end
    when :unification_station
      modifier += ResourceModifier::MultiplyAllProducedResources.new(0.1) if job.administrator?
    when :trade_station
      modifier += ResourceModifier.new({ trade: { multiplicative: 0.2 } })
    when :generator_station
      modifier += ResourceModifier.new({ energy: { multiplicative: 0.1 } }) if job.technician?
    when :mining_station
      if job.miner?
        modifier += ResourceModifier.new({
                                           minerals: { multiplicative: 0.1 },
                                           exotic_gases: { multiplicative: 0.1 },
                                           rare_crystals: { multiplicative: 0.1 },
                                           volatile_motes: { multiplicative: 0.1 }
                                         })
      end
    end

    modifier
  end

  def pop_output_modifiers(pop)
    modifier = ResourceModifier.new
    modifier += ResourceModifier.new({ trade: { multiplicative: stability_coefficient } })
    modifier += @sector.pop_output_modifiers(pop)

    modifier += ResourceModifier.new({ trade: { multiplicative: 0.2 } }) if @designation == :trade_station

    modifier
  end

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier.new

    @decisions.each { |d| modifier += d.job_upkeep_modifiers(job) }

    case @designation
    when :foundry_station
      modifier += ResourceModifier::MultiplyAllProducedResources.new(-0.2) if job.metallurgist?
    when :factory_station
      modifier += ResourceModifier::MultiplyAllProducedResources.new(-0.2) if job.artisan?
    when :industrial_station
      modifier += ResourceModifier::MultiplyAllProducedResources.new(-0.1) if job.artisan? || job.metallurgist?
    when :unification_station
      modifier += ResourceModifier::MultiplyAllProducedResources.new(-0.1) if job.administrator?
    end

    modifier += @sector.job_upkeep_modifiers(job)

    modifier
  end

  def pop_upkeep_modifiers(_pop)
    ResourceModifier::NONE
  end

  def job_colony_attribute_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @sector.job_colony_attribute_modifiers(job) unless @sector.nil?

    @decisions.each { |d| modifier += d.job_colony_attribute_modifiers(job) }

    modifier
  end

  def job_empire_attribute_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @sector.job_empire_attribute_modifiers(job) unless @sector.nil?

    @decisions.each { |d| modifier += d.job_empire_attribute_modifiers(job) }

    modifier
  end

  def job_amenities_output_modifier(job)
    modifier = 0

    modifier += @sector.job_amenities_output_modifier(job) unless @sector.nil?

    @decisions.each { |d| modifier += d.job_amenities_output_modifier(job) }

    modifier
  end

  def job_stability_modifier(job)
    modifier = 0

    modifier += @sector.job_stability_modifier(job) unless @sector.nil?

    @decisions.each { |d| modifier += d.job_stability_modifier(job) }

    modifier
  end

  def job_worker_housing_modifier(job)
    modifier = ResourceModifier::NONE

    modifier += @sector.job_worker_housing_modifier(job) unless @sector.nil?

    @decisions.each { |d| modifier += d.job_worker_housing_modifier(job) }

    modifier
  end

  def building_output(_num, _building)
    ResourceGroup.new
  end

  def building_upkeep(num, building)
    upkeep = ResourceGroup.new

    if %i[habitat_central_control habitat_administration].include?(building)
      upkeep[:energy] = 3 * num
      upkeep[:alloys] = 5 * num
    elsif %i[research_labs administrative_offices holo_theatres hydroponics_farms luxury_residences
             communal_housing energy_grid mineral_purification_plants food_processing_facilities alloy_foundries civilian_industries].include?(building)
      upkeep[:energy] = 2 * num
    end

    upkeep
  end

  def output
    pop_output = @pops.reduce(ResourceGroup.new) do |sum, pop|
      sum + pop.output
    end

    building_output = @buildings.reduce(ResourceGroup.new) do |sum, (building, num)|
      sum + building_output(num, building)
    end

    deposits_output = @deposits.reduce(ResourceGroup.new) do |sum, deposit|
      sum + deposit
    end

    pop_output + building_output + deposits_output
  end

  def upkeep
    pop_upkeep = @pops.reduce(ResourceGroup.new) do |sum, pop|
      sum + pop.upkeep
    end

    building_upkeep = @buildings.reduce(ResourceGroup.new) do |sum, (building, num)|
      sum + building_upkeep(num, building)
    end

    district_upkeep = @districts.reduce(ResourceGroup.new({})) do |sum, d|
      sum + d.upkeep
    end

    pop_upkeep + building_upkeep + district_upkeep
  end

  def attributes
    return @attributes if @attributes

    colony_attributes = ResourceGroup.new({
                                            defense_armies: 0,
                                            offspring_led_armies: 0
                                          })

    @pops.each { |pop| colony_attributes << pop.colony_attribute_modifiers }
    @districts.each { |pop| colony_attributes << pop.colony_attribute_modifiers }

    colony_attributes << @sector.colony_attribute_modifiers

    @attributes = colony_attributes.resolve

    @attributes
  end

  def defense_armies
    attributes[:defense_armies] || 0
  end

  def offspring_led_armies
    attributes[:offspring_led_armies] || 0
  end
end
