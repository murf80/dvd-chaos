class Director < ActiveRecord::Base
  attr_accessible :name, :dob, :gender, :dvds

  validates_uniqueness_of :name
  validates_presence_of :name

  validates_presence_of :gender
  validates_inclusion_of :gender, :in => [ "male", "female" ]

  has_many :dvds
end
