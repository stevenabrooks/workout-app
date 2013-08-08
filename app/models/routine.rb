class Routine < ActiveRecord::Base
  attr_accessible :name, :date, :user_id

  belongs_to :user
  has_many :lifts, dependent: :destroy
  has_many :exercises, through: :lifts

  def graph_first_line
    array = ["exercise"]
    self.most_reps.times do |n|
      array << "set #{n+1}"
    end
    array
  end

  def graph
    array = []
    array << self.graph_first_line
    self.lifts.each do |lift|
      array << lift.chart_info_for_lift
    end
    array
  end

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

  def most_reps
    size = 0
    self.lifts.each do |lift|
      size = lift.infos.size if lift.infos.size > size
    end
    size
  end

end
