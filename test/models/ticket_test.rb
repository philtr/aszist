require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  should validate_presence_of(:user_id)

  should "set status to 'pending' on create" do
    ticket = create(:ticket)
    assert ticket.status == "pending", "Did not set ticket status to 'pending' on create."
  end

  should "not save if the status is not in the list" do
    ticket = build(:ticket)
    ticket.status = "forgotten"
    assert !ticket.save, "Saved with a status not in the list."
  end

  should "return an array of all tickets with status 'pending'" do
    create(:ticket_pending_low)
    create(:ticket_pending_high)

    pending_tickets = Ticket.pending_tickets.count
    assert pending_tickets == 2, "Returned incorrect number of tickets (#{ pending_tickets })."
  end

  should "return an array of all tickets with status 'open'" do
    create(:ticket_open_low)
    create(:ticket_open_high)

    open_tickets = Ticket.open_tickets.count
    assert open_tickets == 2, "Returned incorrect number of tickets (#{ open_tickets })."
  end

  should "return an array of all tickets with status 'closed'" do
    create(:ticket_closed_low)
    create(:ticket_closed_high)

    closed_tickets = Ticket.closed_tickets.count
    assert closed_tickets == 2, "Returned incorrect number of tickets (#{ closed_tickets })."
  end

  should "return an array of all tickets with priority 'low'" do
    create(:ticket_open_low)
    create(:ticket_closed_low)

    low_priority_tickets = Ticket.low_priority.count
    assert low_priority_tickets == 2, "Returned incorrect number of tickets (#{ low_priority_tickets })."
  end

  should "return an array of all tickets with priority 'medium'" do
    create_list(:medium_priority_ticket, 2)
    assert Ticket.medium_priority.count == 2, "Returned incorrect number of tickets (#{Ticket.medium_priority.count})."
  end

  should "return an array of all tickets with priority 'high'" do
    create_list(:high_priority_ticket, 2)
    assert Ticket.high_priority.count == 2, "Returned incorrect number of tickets (#{Ticket.high_priority.count})."
  end

end
