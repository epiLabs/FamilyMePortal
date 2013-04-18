class Invitation < ActiveRecord::Base
  attr_accessible :email

  belongs_to :family
  belongs_to :user

  validates :email, :uniqueness => {:scope => :family_id}, format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, message: "Bad email format"}
  validates :family_id, presence: true
  validates :user_id, presence: true

  validates_inclusion_of :status, :in => %w(pending accepted rejected)
end
