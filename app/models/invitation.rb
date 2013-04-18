class Invitation < ActiveRecord::Base
  belongs_to :family
  belongs_to :user
end
