class Routine < ActiveRecord::Base
  attr_accessible :name, :date

  has_many :lifts
  has_many :exercises, through: :lifts

  def date
    @date
  end

  def date=(date_string)
    @date = date_string.to_date
  end

  # accepts_nested_attributes_for :exercises, allow_destroy: true, :reject_if => lambda { |a| a[:name].blank? }

  # def exercise_name
  #   exercises.try(:name) 
  # end

  # def exercise_name=(name)
  #   self.exercises << Exercise.find_by_name(name) if name.present?
  # end

end
