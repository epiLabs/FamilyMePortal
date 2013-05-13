class Task < ActiveRecord::Base
  attr_accessible :finished, :name, :user_id
end
