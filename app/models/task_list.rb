class TaskList < ActiveRecord::Base
  attr_accessible :description, :title

  belongs_to :family
  belongs_to :author, class_name: "User", :foreign_key => 'author_id'
  has_many :tasks

  validates :family_id, presence: true
  validates :title,
    presence: true,
    format: {with: /\A\w[\w\s]{2,}\w\z/, message: "Bad format"} # 4 characters at least

  before_validation :trim_title_and_description

  def trim_title_and_description
    self.title = title.strip if title.present?
    self.description = description.strip if description.present?
  end

  def status
    if tasks.finished.count == tasks.count
      "finished"
    else
      "open"
    end
  end
end
