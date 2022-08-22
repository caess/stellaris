# frozen_string_literal: true

require 'forwardable'

require_relative './job'
require_relative './mixins'
require_relative './resource_group'

class PopJob
  include OutputsResources
  include UsesAmenities
  extend Forwardable

  def_delegators :@job, :all_job_output_modifiers, :pop_happiness_modifiers,
                 :ruler?, :specialist?, :worker?, :slave?,
                 :menial_drone?, :complex_drone?,
                 :farmer?, :miner?, :strategic_resource_miner?, :livestock?,
                 :technician?, :politician?, :executive?, :noble?, :administrator?,
                 :manager?, :priest?, :telepath?, :researcher?, :metallurgist?,
                 :culture_worker?, :evaluator?, :refiner?, :translucer?, :chemist?,
                 :artisan?, :bio_trophy?, :pop_assembler?, :necro_apprentice?,
                 :merchant?, :entertainer?, :soldier?, :enforcer?, :doctor?

  attr_reader :job, :worker

  def initialize(job:, worker:)
    @job = job
    @worker = worker
  end

  def output
    output = @job.output

    output << @worker.job_output_modifiers(self)

    output
  end

  def upkeep
    upkeep = @job.upkeep

    upkeep << @worker.job_upkeep_modifiers(self)

    upkeep
  end

  def colony_attribute_modifiers
    modifiers = ResourceModifier.new
    modifiers += @job.colony_attribute_modifiers
    modifiers += @worker.job_colony_attribute_modifiers(self)

    modifiers
  end

  def empire_attribute_modifiers
    modifiers = ResourceModifier.new
    modifiers += @job.empire_attribute_modifiers
    modifiers += @worker.job_empire_attribute_modifiers(self)

    modifiers
  end

  def amenities_output
    output = @job.amenities_output
    output += @worker.job_amenities_output_modifier(self)

    output
  end

  def stability_modifier
    modifier = @job.stability_modifier
    modifier += @worker.job_stability_modifier(self)

    modifier
  end

  def worker_housing_modifier
    modifiers = ResourceModifier.new
    modifiers += @job.worker_housing_modifier
    modifiers += @worker.job_worker_housing_modifier(self)

    modifiers
  end
end
