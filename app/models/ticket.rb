class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent, :class_name => "User"
  has_many :comments

  accepts_nested_attributes_for :comments

  has_paper_trail

  Statuses = ["pending","open","closed"]
  Priorities = ["low","medium","high"]

  validates :user_id, :presence => true
  validates :status, :inclusion => { :in => Ticket::Statuses }

  before_validation :set_pending, :create_user

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

end
