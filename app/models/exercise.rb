class Exercise < ActiveRecord::Base
  attr_accessible :name

  has_many :lifts
  has_many :routines, through: :lifts

  validates_presence_of :name
end
