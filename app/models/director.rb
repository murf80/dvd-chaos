class Director < ActiveRecord::Base
  attr_accessible :name, :dob, :gender

  belongs_to :dvd
end
