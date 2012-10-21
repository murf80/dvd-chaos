class Dvd < ActiveRecord::Base
  attr_accessible :[name, :asin, :release_date, :summary

  has_many :actors

  has_one :director
end
