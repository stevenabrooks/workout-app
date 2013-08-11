class Lift < ActiveRecord::Base
  attr_accessible :routine_id, :exercise_id

  belongs_to :routine
  belongs_to :exercise
  has_many :infos, dependent: :destroy

  def chart_info_for_lift
    goal = []
    goal << self.exercise.name
    self.infos.each do |info|
      goal << info.total_weight_per_info
    end
    goal
  end

# ["Reverse DB Flys", 150, 200, 250, "10 reps at 15 pounds, 10 reps at 20 pounds, 10 reps at 25 pounds"] 
  def routine_tooltip
    array = self.chart_info_for_lift
    array << self.infos_string
  end

  def infos_string_array
    array = self.lift_date_and_weight
    array << self.infos_string
  end

  def infos_string
    array = []
    self.infos.each do |info|
      array << info.info_string
    end
    array.join(", ")
  end

  def something
    array = []
    array << self.lift_date_and_weight_string
    array << self.infos_string_array
    array 
  end

  def lift_date_and_weight
    array = []
    array << self.routine.date 
    array << self.total_weight_per_lift
  end

  # ["2013-08-01", 600] 
  def lift_date_and_weight_string
    array = []
    array << self.routine.date 
    array << self.total_weight_per_lift.to_s
  end

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
  
  # def sort_lifts_by_routine_date(exercise_id)
  #   a = Lift.where(:exercise_id => self.id)
  #   b = a.sort_by { |lift| lift.routine.date }.reverse     
  #   b
  # end

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