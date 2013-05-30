class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :title, :description
end
