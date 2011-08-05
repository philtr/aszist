class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent, :class_name => "User"
  has_many :comments

  accepts_nested_attributes_for :comments

  has_paper_trail

  Statuses = ["pending","open","closed"]
  Priorities = ["low","medium","high"]

  validates :user, :presence => true
  validates :status, :inclusion => { :in => Ticket::Statuses }
  validates :priority, :inclusion => { :in => Ticket::Priorities }
  validates :token, :presence => true, :uniqueness => true

  before_validation :set_pending, :create_user
  before_create :generate_token

  default_scope :order => "created_at DESC"

  scope :pending_tickets, where(:status => "pending")
  scope :open_tickets,    where(:status => "open")
  scope :closed_tickets,  where(:status => "closed")

  scope :low_priority,    where(:priority => "low")
  scope :medium_priority, where(:priority => "medium")
  scope :high_priority,   where(:priority => "high")


  def date
    self.created_at.strftime('%b %d')
  end

private

  def set_pending
    self.status = "pending" if self.status.to_s.empty?
  end

  def create_user
    if self.user.nil?
      # TODO: Create new user for email and assign to ticket
    end
  end

  def generate_token
    if self.token.nil?
      begin
        random_token = SecureRandom.hex(16)
      end while Ticket.find_by_token(random_token) == []
      self.token = random_token
    end
  end

end
