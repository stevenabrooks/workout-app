class User < ActiveRecord::Base
  attr_accessible :name

  has_many :routines

  def graph_for_total_weight_over_time(exercise_id)
    array = [["Date", "Total Weight"]]
    b = Lift.where(:exercise_id => exercise_id)
    b.each do |lift|
      array << lift.lift_date_and_weight
    end
  array
  end

end

