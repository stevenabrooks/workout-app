class Routine < ActiveRecord::Base
  attr_accessible :name, :date

  has_many :lifts, dependent: :destroy
  has_many :exercises, through: :lifts

  def total_weight_per_routine
    counter = 0
    self.lifts.each do |lift|
      tw = lift.total_weight_per_lift
      counter += tw
    end  
    counter
  end

  def total_reps_per_routine
    counter = 0
    self.lifts.each do |lift|
      tw = lift.total_reps_per_lift
      counter += tw
    end  
    counter
  end

  def total_sets_per_routine
    counter = 0
    self.lifts.each do |lift|
      tw = lift.total_sets_per_lift
      counter += tw
    end  
    counter
  end

end
