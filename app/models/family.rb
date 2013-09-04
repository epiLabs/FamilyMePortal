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

  # Statistic purpose methods below
  # TODO : This is a bit too overkill, think about using counter_cache
  def total_task_lists_count
    task_lists.count
  end
  def finished_task_lists_count
    task_lists.select{ |task_list| task_list.completed? }.count
  end
  def open_task_lists_count
    task_lists.select{ |task_list| task_list.open? }.count
  end
  def empty_task_lists_count
    task_lists.select{ |task_list| task_list.empty? }.count
  end

  def total_events_count
    events.count
  end
  def total_incoming_events_count
    events.currents_and_futures.count
  end

  def accepted_invitations_count
    invitations.accepted.count
  end
  def rejected_invitations_count
    invitations.rejected.count
  end
  def pending_invitations_count
    invitations.pending.count
  end
end
