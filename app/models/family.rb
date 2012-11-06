class Family < ActiveRecord::Base
  attr_accessible :name

  validate :name, presence: true

  has_many :users

end
