class Lift < ActiveRecord::Base
  attr_accessible :name

  belongs_to :routine
  belongs_to :exercise
end
