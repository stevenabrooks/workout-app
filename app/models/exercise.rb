class Exercise < ActiveRecord::Base
  attr_accessible :name

  has_many :lifts
  has_many :routines, through: :lifts

  validates_presence_of :name

  letsrate_rateable "difficulty", "pump", "rest", "effectiveness"

  def sort_lifts_by_routine_date
    c = []
    a = Lift.where(:exercise_id => self.id)
    b = a.sort_by { |lift| lift.routine.date }     
    b.each do |lift|
      c << lift.lift_date_and_weight
    end
    c
  end

end
