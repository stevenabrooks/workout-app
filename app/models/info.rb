class Info < ActiveRecord::Base
  attr_accessible :repetition, :weight, :lift_id

  belongs_to :lift


  def total_weight_per_info
    self[:repetition] * self[:weight]
  end

  def exercise_name_from_info
    lift_id = self.lift_id
    lift = Info.where(:lift_id => a)
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
end
