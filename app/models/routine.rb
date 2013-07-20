class Routine < ActiveRecord::Base
  attr_accessible :name

  has_many :lifts
  has_many :exercises, through: :lifts
end
