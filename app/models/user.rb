class User < ActiveRecord::Base
  attr_accessible :name

  has_many :routines
end
