class Invitation < ActiveRecord::Base
  attr_accessible :email

  belongs_to :family
  belongs_to :user

  validates :email, :uniqueness => {:scope => :family_id}, format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, message: "Bad email format"}
  validates :family_id, presence: true
  validates :user_id, presence: true

  validates_inclusion_of :status, :in => %w(pending accepted rejected)

  after_create :send_email

  def send_email
    Notifier.send_invitation(self).deliver
  end

  def accept!(user)
    if !user.family && user.email == email
      user.family = family
      user.save!

      self.status = "accepted"
      save!

      true
    end
  end

  def reject!(user)
    if user.email == email
      self.status = "rejected"
      save!

      true
    end
  end
end
