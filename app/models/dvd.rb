class Dvd < ActiveRecord::Base
  attr_accessible :name, :asin, :release_date, :summary

  validates_uniqueness_of :name

  has_and_belongs_to_many :actors

  has_one :director
end
