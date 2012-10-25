class Director < ActiveRecord::Base
  attr_accessible :name, :dob, :gender, :dvd

  validates_uniqueness_of :name
  validates_presence_of :name

  validates_presence_of :gender
  validates_inclusion_of :gender, :in => [ "male", "female" ]

  belongs_to :dvd, foreign_key: :dvd_id
end
