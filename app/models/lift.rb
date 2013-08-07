class Lift < ActiveRecord::Base
  attr_accessible :routine_id, :exercise_id

  belongs_to :routine
  belongs_to :exercise
  has_many :infos, dependent: :destroy

  def compared_to_last_lift_weight
    ei = self.exercise_id
    array = Lift.where(:exercise_id => ei).last(2)
    number_difference = array[1].total_weight_per_lift - array[0].total_weight_per_lift
    number_difference
  end

  def compared_to_last_lift_weight_percentage
    ei = self.exercise_id
    array = Lift.where(:exercise_id => ei).last(2)
    number1 = (array[1].total_weight_per_lift * 100.0)
    number2 = (array[0].total_weight_per_lift)
    percentage = ((number1) / number2) - 100
    percentage
  end

  def compared_to_last_lift_reps
    ei = self.exercise_id
    array = Lift.where(:exercise_id => ei).last(2)
    number_difference = array[1].total_reps_per_lift - array[0].total_reps_per_lift
    number_difference
  end

  def compared_to_last_lift_sets
    ei = self.exercise_id
    array = Lift.where(:exercise_id => ei).last(2)
    number_difference = array[1].infos.size - array[0].infos.size
    number_difference
  end


  def total_weight_per_lift
    counter = 0
    self.infos.each do |info|
      tw = info.total_weight_per_info
      counter += tw
    end  
    counter
  end

  def total_reps_per_lift
    counter = 0
    self.infos.each do |info|
      tw = info.repetition
      counter += tw
    end  
    counter
  end

  def total_sets_per_lift
    self.infos.size
  end


  def self.find_most_weight_used_by_exercise_id(exercise_id)
    b = []
    a = self.where(:exercise_id => exercise_id)
    a.each do |lift|
      lift.infos.each do |info|
        b << info
      end
      b = b.sort_by { |info| info.weight }.reverse
    end 
    b.first.weight 
  end

  def self.find_set_with_most_weight_used_by_exercise_id(exercise_id)
    b = []
    a = self.where(:exercise_id => exercise_id)
    a.each do |lift|
      lift.infos.each do |info|
        b << info
      end
      b = b.sort_by { |info| info.weight }.reverse
    end 
    b.first 
  end

  def self.find_best_set_total_weight_by_exercise_id(exercise_id)
    b = []
    a = self.where(:exercise_id => exercise_id)
    a.each do |lift|
      lift.infos.each do |info|
        b << info
      end
      b = b.sort_by { |info| info.total_weight_per_info }.reverse
    end 
    b.first.total_weight_per_info
  end 

end