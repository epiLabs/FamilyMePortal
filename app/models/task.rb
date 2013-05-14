class Task < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user
  belongs_to :task_list

  validates :task_list_id, presence: true
  validates :title,
    presence: true,
    :uniqueness => {:scope => :task_list_id, message: 'Task already exists'},
    format: {with: /\A\w[\w\s]{2,}\w\z/, message: "Bad format"} # 4 characters at least

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
