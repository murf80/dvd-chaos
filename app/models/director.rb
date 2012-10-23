class Director < ActiveRecord::Base
  attr_accessible :name, :dob, :gender

  validates_uniqueness_of :name

  validates_presence_of :gender

  belongs_to :dvd
end
