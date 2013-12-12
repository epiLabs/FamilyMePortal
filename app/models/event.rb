class Event < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :title, :description

  belongs_to :family
  belongs_to :user

  validates :family_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :title,
    presence: true,
    format: {with: /\A\w.{2,}+\w\z/, message: "Bad format"} # 2 characters at least

  before_validation :trim_title_and_description

  validate :end_date_cannot_be_past_start_date

  def trim_title_and_description
    self.title = title.strip if title.present?
    self.description = description.strip if description.present?
  end

  def end_date_cannot_be_past_start_date
    if !start_date.blank? && !end_date.blank? and end_date < start_date
      errors.add(:end_date, "Must be greater than start_date")
    end
  end

  def self.currents_and_futures(from = Time.now)
    where('end_date > ? OR start_date > ?', from, from)
  end

  def to_ics
    event = Icalendar::Event.new

    event.dtstart = start_date.to_time
    event.dtend = end_date.to_time
    event.summary = title
    event.description = description
    p event
    event
  end
end
