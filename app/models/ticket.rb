class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent, :class_name => "User"
  has_many :comments

  accepts_nested_attributes_for :comments

  has_paper_trail

  STATUSES = %w( pending open closed )
  PRIORITIES = %w( low medium high )

  validates :user_id, :presence => true
  validates :status, :inclusion => { :in => Ticket::STATUSES }
  validates :priority, :inclusion => { :in => Ticket::PRIORITIES }
  validates :token, :presence => true, :uniqueness => true

  before_validation :set_pending,
                    :set_default_priority,
                    :create_user,
                    :generate_token

  def date
    self.created_at.strftime('%b %d')
  end

  def self.newest_first
    order("created_at DESC")
  end

  def self.pending_tickets
    where(status: "pending")
  end

  def self.open_tickets
    where(status: "open")
  end

  def self.closed_tickets
    where(status: "closed")
  end

  def self.low_priority
    where(priority: "low")
  end

  def self.medium_priority
    where(priority: "medium")
  end

  def self.high_priority
    where(priority: "high")
  end

  def self.visible(user)
    if user.role?(:admin)
      all
    else
      where("user_id = ? OR agent_id = ?", user.id, user.id)
    end
  end

  # Will not return an ActiveRecord::Relation!
  def self.group_by_status
    all.group_by(&:status)
  end

  protected

  def set_pending
    self.status = STATUSES.first if self.status.blank?
  end

  def set_default_priority
    self.priority = PRIORITIES.first if self.priority.blank?
  end

  def create_user
    if self.user.blank?
      # TODO: Create new user for email and assign to ticket
    end
  end

  def generate_token
    self.token = SecureRandom.hex(64) if self.token.blank?
  end

end
