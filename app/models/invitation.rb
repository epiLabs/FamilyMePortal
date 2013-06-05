class Invitation < ActiveRecord::Base
  attr_accessible :email

  belongs_to :family
  belongs_to :user

  validates :email,
    presence:true,
    :uniqueness => {:scope => :family_id, message: 'Invitation already exists'},
    format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, message: "Bad email format"}
  validates :family_id, presence: true
  validates :user_id, presence: true

  validates_inclusion_of :status, :in => %w(pending accepted rejected)

  after_create :send_email

  before_validation :check_that_user_has_no_family, :on => :create

  def check_that_user_has_no_family
    user = User.find_by_email email
    if user && user.family.present?
      errors.add :email, 'This user is already in a family!'
    end
  end

  def send_email
    Notifier.send_invitation(self).deliver
  end

  def accept!(user)
    if !user.family && user.email == email
      user.family_id = family_id
      user.save!

      self.status = "accepted"
      save!

      self.class.reject_all!(user)

      true
    end
  end

  def self.reject_all!(user)
    where(email: user.email, status: 'pending').update_all(status: 'rejected')
  end

  def reject!(user)
    if user.email == email
      self.status = "rejected"
      save!

      true
    end
  end

  def get_table_row_class
    case status
    when 'pending'
      'warning'
    when 'declined'
      'error'
    when 'accepted'
      'success'
    else
      raise "THIS IS NOT SUPOSED TO HAPPEN"
    end
  end
end
