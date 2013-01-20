class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,
  # :rememberable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name

  belongs_to :family

  after_invitation_accepted :join_invitor_family

  def join_invitor_family
    self.family = invited_by.family
  end
end
