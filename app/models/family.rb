class Family < ActiveRecord::Base
  has_many :users
  has_many :posts

  def self.generate_new_including_user user
    unless user.family.present?
      family = Family.new
      family.users << user
      family.save!
    end

    user.family
  end
end
