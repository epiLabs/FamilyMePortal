class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable,
  # :lockable, :timeoutable and :omniauthable,
  # :rememberable
  devise :token_authenticatable, :invitable, :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nickname, :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name

  belongs_to :family

  before_save :ensure_authentication_token

  #Reset authentication token in certain circumstances
  #before_save :reset_authentication_token

  after_invitation_accepted :join_invitor_family

  def join_invitor_family
    self.family = invited_by.family
  end
end
