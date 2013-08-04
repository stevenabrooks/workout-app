class Lift < ActiveRecord::Base
  attr_accessible :routine_id, :exercise_id

  belongs_to :routine
  belongs_to :exercise
  has_many :infos
end


# def self.find_most_weight_used_by_exercise_id(exercise_id)
#   b = []
#   a = self.where(:exercise_id => exercise_id)
#   a.each do |lift|
#     lift.infos.each do |info|
#       b << info
#     end
#     b.sort_by { |info| info.weight }.reverse
#   end 
# end