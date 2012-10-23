class Actor < ActiveRecord::Base
  attr_accessible :dob, :gender, :name

  validates_uniqueness_of :name

  has_and_belongs_to_many :dvds
end
