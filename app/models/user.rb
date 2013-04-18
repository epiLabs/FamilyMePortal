class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable
  devise :token_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nickname, :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name, :provider, :uid

  has_many :positions, dependent: :destroy
  has_many :posts, :foreign_key => 'author_id'
  belongs_to :family

  before_save :ensure_authentication_token

  include Gravtastic
  gravtastic default: 'mm'

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.find_by_email(auth.info.email)

      unless user
        password = Devise.friendly_token[0,10]
        user = User.new(email: auth.info.email, password: password, password_confirmation: password)
      end

      # Fill new user informations or update current one
      user.first_name = auth.info.first_name unless user.first_name.present?
      user.last_name = auth.info.last_name unless user.last_name.present?
      user.nickname = auth.info.nickname unless user.nickname.present?
      user.uid = auth.uid
      user.provider = auth.provider

      user.save
    end
    user
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

  def gravatar(size = 40)
    gravatar_url(size: size)
  end
end
