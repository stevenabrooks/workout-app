class Info < ActiveRecord::Base
  attr_accessible :repetition, :weight, :lift_id

  belongs_to :lift

  def find_routine_by_info
    self.lift.routine  
  end

  def total_weight_per_info
    self[:repetition] * self[:weight]
  end

  def exercise_name_from_info
    lift_id = self.lift_id
    lift = Lift.where(:id => lift_id).first
    lift.exercise.name
  end

  def compare_infos?(first,second)
    first < second
  end

  def was_each_info_better_than_the_last?
    infos = self.lift.infos
    infos.each_with_index do |info, index|
      p compare_infos?(info.total_weight_per_info, infos[index+1].total_weight_per_info) if index < infos.size - 1
    end  
  end

  def info_string
    "#{self.repetition} reps at #{self.weight} pounds"
  end

# this would be for the form to happen dynamically
  # def was_this_info_better_than_last?
  #   if self.lift.infos.size > 0
  #     infos = self.lift.infos.last(2)     
  #   else
  #   end
  #   if (infos[1].total_weight_per_info) > (infos[0].total_weight_per_info)
  #     puts "good set"
  #   else
  #     puts "you can do better"
  #   end
  # end

end
