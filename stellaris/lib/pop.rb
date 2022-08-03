require 'forwardable'

require_relative './mixins'
require_relative './pop_job'
require_relative './resource_group'
require_relative './resource_modifier'

class Pop
  include UsesAmenities, OutputsResources
  extend Forwardable

  def_delegators :@job, :all_job_output_modifiers

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

    modifier += @species.job_output_modifiers(job)
    modifier += @colony.job_output_modifiers(job)

    modifier
  end

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @colony.job_upkeep_modifiers(job)

    modifier
  end

  def pop_output
    output = ResourceGroup.new()

    if @species.living_standard == :shared_burden
      output[:trade] = 0.25
    elsif @species.living_standard == :utopian_abundance
      output[:trade] = 0.5
    end

    output << @colony.pop_output_modifiers(self)

    output
  end

  def pop_upkeep
    upkeep = ResourceGroup.new()

    if @species.living_standard == :shared_burden
      upkeep[:consumer_goods] = 0.4
    elsif @species.living_standard == :utopian_abundance
      upkeep[:consumer_goods] = 1
    end
    upkeep[:food] = 1

    upkeep << @colony.pop_upkeep_modifiers(self)

    upkeep
  end

  def stability_modifier
    @job.stability_modifier
  end

  def output
    @job.output + pop_output
  end

  def upkeep
    @job.upkeep + pop_upkeep
  end
end
