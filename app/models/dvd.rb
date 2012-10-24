class Dvd < ActiveRecord::Base
  attr_accessible :name, :asin, :release_date, :summary, :actors, :director

  validates_uniqueness_of :name

  validates_presence_of :summary

  has_and_belongs_to_many :actors

  has_one :director, primary_key: :dvd_id
end
