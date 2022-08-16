require "forwardable"

require_relative "./job"
require_relative "./mixins"
require_relative "./resource_group"

class PopJob
  include UsesAmenities, OutputsResources
  extend Forwardable

  def_delegators :@job, :amenities_output, :stability_modifier,
    :all_job_output_modifiers, :pop_happiness_modifiers,
    :ruler?, :specialist?, :worker?, :slave?,
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
end
