class Actor < ActiveRecord::Base
  attr_accessible :dob, :gender, :name, :dvds

  validates_uniqueness_of :name
  validates_presence_of :name

  validates_presence_of :gender
  validates_inclusion_of :gender, :in => [ "male", "female" ]

  has_and_belongs_to_many :dvds
end
