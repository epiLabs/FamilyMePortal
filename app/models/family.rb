class Family < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
    :message => "Only letters allowed"}, :length => { :minimum => 3 }

  has_many :users

end
