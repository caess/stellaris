require_relative './mixins'
require_relative './resource_group'

class PopJob
  include UsesAmenities, OutputsResources

  attr_reader :job, :worker

  def initialize(job:, worker:)
    @job = job
    @worker = worker
  end

  def specialist?
    [
      :metallurgist, :catalytic_technician, :artisan, :artificer,
      :pearl_diver, :chemist, :gas_refiner, :translucer, :colonist,
      :roboticist, :medical_worker, :entertainer, :duelist, :enforcer,
      :telepath, :necromancer, :reassigner, :necrophyte, :researcher,
      :bureaucrat, :manager, :priest, :death_priest, :death_chronicler,
      :culture_worker,
    ].include?(@job)
  end

  def amenities_output
    if @job == :politician or @job == :science_director or @job == :colonist
      3
    elsif @job == :entertainer
      10
    elsif @job == :clerk
      2
    else
      0
    end
  end

  def stability_modifier
    if @job == :enforcer
      1
    else
      0
    end
  end

  def output
    output = ResourceGroup.new()

    if @job == :politician
      output[:unity] = 6
    elsif @job == :science_director
      output[:physics_research] = 6
      output[:society_research] = 6
      output[:engineering_research] = 6
      output[:unity] = 2
    elsif @job == :metallurgist
      output[:alloys] = 3
    elsif @job == :artisan
      output[:consumer_goods] = 6
    elsif @job == :colonist
      output[:food] = 1
    elsif @job == :entertainer
      output[:unity] = 1
    elsif @job == :researcher
      output[:physics_research] = 4
      output[:society_research] = 4
      output[:engineering_research] = 4
    elsif @job == :bureaucrat
      output[:unity] = 4
    elsif @job == :clerk
      output[:trade] = 4
    elsif @job == :technician
      output[:energy] = 6
    elsif @job == :miner
      output[:minerals] = 4
    elsif @job == :farmer
      output[:food] = 6
    end

    output << @worker.job_output_modifiers(self)

    output
  end

  def upkeep
    upkeep = ResourceGroup.new()

    if @job == :politician or @job == :science_director or @job == :researcher or @job == :bureaucrat
      upkeep[:consumer_goods] = 2
    elsif @job == :metallurgist or @job == :artisan
      upkeep[:minerals] = 6
    elsif @job == :entertainer
      upkeep[:consumer_goods] = 1
    end

    upkeep << @worker.job_upkeep_modifiers(self)

    upkeep
  end
end
