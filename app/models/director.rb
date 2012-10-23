class Director < ActiveRecord::Base
  attr_accessible :name, :dob, :gender

  validates_uniqueness_of :name

  belongs_to :dvd
end
