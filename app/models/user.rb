class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable
  devise :token_authenticatable, :invitable, :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nickname, :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name, :provider, :uid

  has_many :positions
  has_many :posts, :foreign_key => 'author_id'
  belongs_to :family

  before_save :ensure_authentication_token

  after_invitation_accepted :join_invitor_family

  include Gravtastic
  gravtastic default: 'mm'

  def join_invitor_family
    self.family = invited_by.family
  end

  def latitude
    positions.last.try(:latitude)
  end

  def longitude
    positions.last.try(:longitude)
  end

  def last_sign_in_date_formated
    if last_sign_in_at.present?
      last_sign_in_at.strftime("%d %b %y %H:%M")
    end
  end
end
