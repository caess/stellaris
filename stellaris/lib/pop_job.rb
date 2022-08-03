require_relative './job'
require_relative './mixins'
require_relative './resource_group'

class PopJob
  include UsesAmenities, OutputsResources

  attr_reader :job, :worker

  def initialize(job:, worker:)
    @job = Job.lookup(job)
    @worker = worker
  end

  def specialist?
    @job.specialist?
  end

  def amenities_output
    @job.amenities_output
  end

  def stability_modifier
    @job.stability_modifier
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
