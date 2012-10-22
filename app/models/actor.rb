class Actor < ActiveRecord::Base
  attr_accessible :dob, :gender, :name

  has_and_belongs_to_many :dvds
end
