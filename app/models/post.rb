class Post < ActiveRecord::Base
  attr_accessible :message
  
  belongs_to :author, class_name: "User", :foreign_key => 'author_id'
  belongs_to :family

  validates :author_id, presence: true
  validates :family_id, presence: true
  validates :message, presence: true

  before_save { |post| post.message = post.message.strip }

  def date_posted
    created_at.strftime("%d %b %y %H:%M")
  end
end
