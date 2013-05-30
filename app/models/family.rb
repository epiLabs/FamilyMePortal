class Family < ActiveRecord::Base
  has_many :users
  has_many :posts, :dependent => :destroy
  has_many :invitations, :dependent => :destroy
  has_many :task_lists, dependent: :destroy
  has_many :events, dependent: :destroy

  def self.generate_new_including_user user
    unless user.family.present?
      family = Family.new
      family.users << user
      family.save!
    end

    user.family
  end
end
