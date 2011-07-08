class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent, :class_name => "User"

  Statuses = ["pending","open","closed"]

  validates :user_id, :presence => true
  validates :status, :inclusion => { :in => Ticket::Statuses }

  before_validation :set_pending

  scope :pending_tickets, where(:status => "pending")
  scope :open_tickets,    where(:status => "open")
  scope :closed_tickets,  where(:status => "closed")


private

  def set_pending
    self.status = "pending" if self.status.to_s.empty?
  end

end
