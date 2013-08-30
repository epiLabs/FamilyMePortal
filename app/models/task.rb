class Task < ActiveRecord::Base
  attr_accessible :title, :user_id, :user

  belongs_to :user
  belongs_to :task_list

  validates :task_list_id, presence: true
  validates :title,
    presence: true,
    :uniqueness => {:scope => :task_list_id, message: 'Task already exists'},
    format: {with: /\A\S.{2,}\S\z/, message: "Bad format (At least 4 characters)"} # 4 characters at least

  before_validation :trim_title

  def trim_title
    self.title = title.strip if title.present?
  end

  def finish! cancel = false
    self.finished = !cancel
    save!
  end

  def self.finished
    where(finished: true)
  end
end
