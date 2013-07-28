class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent, :class_name => "User"
  has_many :comments

  accepts_nested_attributes_for :comments

  has_paper_trail

  STATUSES = %w( pending open closed )
  PRIORITIES = %w( low medium high )

  validates :user, :presence => true
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

  def self.by_date
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
