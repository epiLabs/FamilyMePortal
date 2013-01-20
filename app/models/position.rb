class Position < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :user_id
  
  attr_accessible :latitude, :longitude

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end