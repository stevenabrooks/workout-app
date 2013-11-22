class Routine < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user }

  attr_accessible :name, :date, :user_id, :bodyweight, :tag_list
  acts_as_taggable

  belongs_to :user
  has_many :lifts, dependent: :destroy
  has_many :exercises, through: :lifts


# ["exercise", "set 1", "tooltip", "set 2", "tooltip", "set 3", "tooltip", "set 4", "tooltip"] 
  def graph_first_line
    array = ["exercise"]
    self.most_reps.times do |n|
      array << "set #{n+1}" 
      array << 'string'
    end
    array
  end   

  def g
    a = Routine.includes(:lifts => :infos).find(self.id)
    array = ["exercise"]
    a.most_reps.times do |n|
      array << "set #{n+1}" 
      array << 'string'
    end
    array
  end  

  def graph
    array = []
    array << self.graph_first_line
    self.something.each do |lift|
      array << lift
    end
    array
  end

  # def lifts_array2
  #   array2 = []
  #   b = Routine.includes(:lifts, :exercises, :info).find(self.id)
  #   b.lifts.each do |lift|
  #     array2 << lift.chart_info_for_lift
  #   end
  #   array2
  # end

  def lifts_array
    array2 = []
    self.lifts.each do |lift|
      array2 << lift.chart_info_for_lift
    end
    array2
  end

  def max_size
    max = 0
    array2 = self.lifts_array
    array2.each do |array|
      if array.size > max 
        max = array.size
      else
      end
    end
    max
  end

# [["Reverse DB Flys", 150, 200, 250], ["DB Shrugs", 1800, 1440, 1680], ["Dips", 0, 360, 270], ["Pullups", 50, 40, 60], ["Seated DB Cleans", 160, 200, 200], ["Reverse Wrist Curls", 350, 400, 450], ["Toe to Bar", 0, 0, 0]] 
  def something
    max = self.max_size
    arrays = self.lifts_array
    arrays.each do |array|
      if array.size < max 
        difference1 = max - array.size
        difference = difference1 / 2
        difference.times do 
          array << 0
          array << "0"
        end
      else
      end
    end
    arrays
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

  def self.by_date
    self.all.sort_by { |routine| routine.date }
  end

  def tooltip
    array = []
    number = self.max_size / 2
    number.times do |n|
      array << "data.setColumnProperty(#{(n+1)*2}, 'role', 'tooltip');"
    end
    array
  end

  def final_tooltip
    self.tooltip.each do |arg|
      arg
    end
  end

  def self.rr(user)
    self.where(:user_id => user.id)
  end

end
























