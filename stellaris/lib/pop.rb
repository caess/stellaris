# frozen_string_literal: true

require 'forwardable'

require_relative './mixins'
require_relative './pop_job'
require_relative './resource_group'
require_relative './resource_modifier'

class Pop
  include OutputsResources
  include UsesAmenities
  extend Forwardable

  def_delegators :@job, :all_job_output_modifiers, :pop_happiness_modifiers

  attr_reader :job

  def initialize(species:, colony:, job:)
    @species = species
    @colony = colony
    @job = PopJob.new(job: job, worker: self)
  end

  def has_job?(job)
    @job.job == Job.lookup(job)
  end

  def specialist?
    @job.specialist?
  end

  def amenities_output
    @job.amenities_output
  end

  def amenities_upkeep
    1
  end

  def happiness
    happiness = 50
    happiness += 5 if @species.living_standard == :shared_burden

    happiness += @colony.pop_happiness_modifiers

    happiness.floor
  end

  def political_power
    1
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @species.job_output_modifiers(job) unless @species.nil?
    modifier += @colony.job_output_modifiers(job) unless @colony.nil?

    modifier
  end

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @species.job_upkeep_modifiers(job) unless @species.nil?
    modifier += @colony.job_upkeep_modifiers(job) unless @colony.nil?

    modifier
  end

  def job_colony_attribute_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @colony.job_colony_attribute_modifiers(job) unless @colony.nil?

    modifier
  end

  def job_empire_attribute_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @colony.job_empire_attribute_modifiers(job) unless @colony.nil?

    modifier
  end

  def job_amenities_output_modifier(job)
    modifier = 0
    modifier += @colony.job_amenities_output_modifier(job) unless @colony.nil?

    modifier
  end

  def job_stability_modifier(job)
    modifier = 0
    modifier += @colony.job_stability_modifier(job) unless @colony.nil?

    modifier
  end

  def job_worker_housing_modifier(job)
    modifier = ResourceModifier::NONE

    modifier += @species.job_worker_housing_modifier(job) unless @species.nil?
    modifier += @colony.job_worker_housing_modifier(job) unless @colony.nil?

    modifier
  end

  def pop_output
    output = ResourceGroup.new

    case @species.living_standard
    when :shared_burden
      output[:trade] = 0.25
    when :utopian_abundance
      output[:trade] = 0.5
    end

    output << @colony.pop_output_modifiers(self) unless @colony.nil?

    output
  end

  def pop_upkeep
    upkeep = ResourceGroup.new

    case @species.living_standard
    when :shared_burden
      upkeep[:consumer_goods] = 0.4
    when :utopian_abundance
      upkeep[:consumer_goods] = 1
    end
    upkeep[:food] = 1

    upkeep << @colony.pop_upkeep_modifiers(self) unless @colony.nil?

    upkeep
  end

  def stability_modifier
    @job.stability_modifier
  end

  def job_output
    @job.output
  end

  def job_upkeep
    @job.upkeep
  end

  def output
    job_output + pop_output
  end

  def upkeep
    job_upkeep + pop_upkeep
  end

  def colony_attribute_modifiers
    modifier = ResourceModifier.new({})

    modifier += @job.colony_attribute_modifiers

    modifier
  end
end
