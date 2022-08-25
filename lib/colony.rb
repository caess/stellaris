# frozen_string_literal: true

require_relative './building'
require_relative './district'
require_relative './job'
require_relative './mixins'
require_relative './pop'
require_relative './resource_group'
require_relative './resource_modifier'

# rubocop:todo Metrics/ClassLength, Style/Documentation

class Colony
  include OutputsResources
  include UsesAmenities

  attr_reader :pops, :districts

  # rubocop:todo Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/ParameterLists
  def initialize(
    type:, size:, sector: nil, designation: nil, districts: {}, buildings: {},
    decisions: {}, jobs: {}, deposits: {}, fill_jobs_with: nil
  )
    @type = type
    @size = size
    @sector = sector
    @sector&.add_colony(self)
    @designation = designation
    @districts = districts.dup
    @buildings = buildings.flat_map { |b| [Building.lookup(b.first)] * b.last }
    @decisions = decisions.dup

    @districts = []
    districts.each do |district_type, number|
      case district_type
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

  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/ParameterLists

  def add_pop(pop)
    @pops << pop
    @attributes = nil
  end

  def buildings(type)
    building_type = Building.lookup(type)
    (@buildings.select { |b| b == building_type }).count
  end

  def num_districts(type)
    @districts.find_all { |d| d == type }.count
  end

  def jobs(job)
    @pops.filter { |pop| pop.job?(job) }.count
  end

  def all_jobs
    @jobs
  end

  # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
  def max_jobs
    max_jobs = (@buildings + @districts).reduce({}) { |sum, x| sum.merge(x.max_jobs) { |_k, v1, v2| v1 + v2 } }

    # FIXME: This needs to be handled through the Void Dweller origin
    hydroponics_farms = buildings(Building::HydroponicsFarms)
    max_jobs[Job::Farmer] += hydroponics_farms if hydroponics_farms.positive?

    # FIXME: Move designations to their own classes
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
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def buildings_amenities_output
    @buildings.reduce(0) { |sum, b| sum + b.amenities_output }
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

  # rubocop:todo Metrics/AbcSize
  def pop_happiness_modifiers
    modifier = 0

    # FIXME: Move Designation to its own class
    modifier += 10 if @designation == :leisure_station

    modifier += @pops.reduce(0) { |sum, pop| sum + pop.pop_happiness_modifiers }

    modifier += if net_amenities.positive?
                  [20, (20.0 * net_amenities / amenities_upkeep)].min
                else
                  [-50, 100 * (2.0 / 3 * net_amenities / amenities_upkeep)].max
                end

    modifier
  end
  # rubocop:enable Metrics/AbcSize

  def approval_rating
    1.0 * @pops.reduce(0) do |sum, pop|
      sum + (pop.happiness * pop.political_power)
    end / @pops.reduce(0) { |sum, pop| sum + pop.political_power }
  end

  def stability_modifier
    @designation == :empire_capital ? 5 : 0
  end

  def stability_from_approval_rating
    if approval_rating > 50
      (0.6 * (approval_rating - 50)).floor
    else
      -1 * (50 - approval_rating).floor
    end
  end

  def stability
    stability = 50 + stability_modifier + @sector.stability_modifier
    stability += @pops.reduce(0) { |sum, pop| sum + pop.stability_modifier }
    stability += stability_from_approval_rating

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

  # rubocop:todo Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def job_output_modifiers(job)
    modifier = ResourceModifier.new
    modifier += @pops.reduce(modifier) { |sum, p| sum + p.all_job_output_modifiers(job) }

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
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

  def pop_output_modifiers(pop)
    modifier = ResourceModifier.new
    modifier += ResourceModifier.new({ trade: { multiplicative: stability_coefficient } })
    modifier += @sector.pop_output_modifiers(pop)

    modifier += ResourceModifier.new({ trade: { multiplicative: 0.2 } }) if @designation == :trade_station

    modifier
  end

  # rubocop:todo Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
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
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

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

  def buildings_output
    @buildings.reduce(ResourceGroup.new) { |sum, b| sum + b.output }
  end

  def buildings_upkeep
    @buildings.reduce(ResourceGroup.new) { |sum, b| sum + b.upkeep }
  end

  def output
    pop_output = @pops.reduce(ResourceGroup.new) do |sum, pop|
      sum + pop.output
    end

    deposits_output = @deposits.reduce(ResourceGroup.new) do |sum, deposit|
      sum + deposit
    end

    pop_output + buildings_output + deposits_output
  end

  def upkeep
    pop_upkeep = @pops.reduce(ResourceGroup.new) do |sum, pop|
      sum + pop.upkeep
    end

    district_upkeep = @districts.reduce(ResourceGroup.new({})) do |sum, d|
      sum + d.upkeep
    end

    pop_upkeep + buildings_upkeep + district_upkeep
  end

  def attributes
    return @attributes if @attributes

    colony_attributes = ResourceGroup.new({
                                            defense_armies: 0,
                                            offspring_led_armies: 0
                                          })

    @pops.each { |pop| colony_attributes << pop.colony_attribute_modifiers }
    @districts.each { |d| colony_attributes << d.colony_attribute_modifiers }

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

  def empire_attribute_modifiers
    modifier = ResourceModifier.new
    @pops.each { |pop| modifier += pop.empire_attribute_modifiers }
    @districts.each { |d| modifier += d.empire_attribute_modifiers }

    modifier
  end
end

# rubocop:enable Metrics/ClassLength, Style/Documentation
