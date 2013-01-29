class Position < ActiveRecord::Base
  belongs_to :user

  validates :latitude, presence: true, :inclusion => -90..90
  validates :longitude, presence: true, :inclusion => -180..180

  validates_presence_of :user_id
  
  attr_accessible :latitude, :longitude

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def date
    updated_at.strftime("%d %b %y %H:%M")
  end
end