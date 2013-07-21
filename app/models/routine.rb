class Routine < ActiveRecord::Base
  attr_accessible :name, :exercises_attributes

  has_many :lifts
  has_many :exercises, through: :lifts

  accepts_nested_attributes_for :exercises, allow_destroy: true, :reject_if => lambda { |a| a[:name].blank? }
end
