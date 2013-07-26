class Info < ActiveRecord::Base
  attr_accessible :repetition, :weight, :lift_id

  belongs_to :lift
end
