require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  def valid_ticket(ticket_name = :pending_low, user_name = :user_one, agent_name = :agent_one)
    ticket = tickets(ticket_name)
    ticket.user = users(:user_one)
    ticket.agent = users(:agent_one)
    ticket.save
    return ticket
  end

  test "should not save without a user" do
    ticket = tickets(:pending_low)
    ticket.agent = users(:agent_one)
    assert !ticket.save, "Saved without a user."
  end

  test "should set status to 'pending' on create" do
    (ticket = valid_ticket).save
    assert ticket.status == "pending",
      "Did not set ticket status to 'pending' on create."
  end

  test "should not save if the status is not in the list" do
    ticket = valid_ticket
    ticket.status = "forgotten"
    assert !ticket.save, "Saved with a status not in the list."
  end

  test "should return an array of all tickets with status 'pending'" do
    valid_ticket(:pending_low)
    valid_ticket(:pending_high)
    assert Ticket.pending_tickets.count == 2,
      "Returned incorrect number of tickets (#{Ticket.pending_tickets.count})."
  end

  test "should return an array of all tickets with status 'open'" do
    assert Ticket.open_tickets.count == 2,
      "Returned incorrect number of tickets (#{Ticket.open_tickets.count})."
  end

  test "should return an array of all tickets with status 'closed'" do
    assert Ticket.closed_tickets.count == 2,
      "Returned incorrect number of tickets (#{Ticket.closed_tickets.count})."
  end

  test "should return an array of all tickets with priority 'low'" do
    assert Ticket.low_priority.count == 3,
      "Returned incorrect number of tickets (#{Ticket.low_priority.count})."
  end

  test "should return an array of all tickets with priority 'medium'" do
    assert Ticket.low_priority.count == 3,
      "Returned incorrect number of tickets (#{Ticket.low_priority.count})."
  end
  
  test "should return an array of all tickets with priority 'high'" do
    assert Ticket.high_priority.count == 3,
      "Returned incorrect number of tickets (#{Ticket.high_priority.count})."
  end

end
