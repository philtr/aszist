require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  should validate_presence_of(:user_id)

  context "The Ticket class" do
    should "not save if the status is not in the list" do
      ticket = build(:ticket)
      ticket.status = "forgotten"
      assert !ticket.save, "Saved with a status not in the list."
    end

    should "return an array of all tickets with status 'pending'" do
      create(:ticket, :pending, :low)
      create(:ticket, :pending, :high)

      pending_tickets = Ticket.pending_tickets.count
      assert pending_tickets == 2, "Returned incorrect number of tickets (#{ pending_tickets })."
    end

    should "return an array of all tickets with status 'open'" do
      create(:ticket, :open, :low)
      create(:ticket, :open, :high)

      open_tickets = Ticket.open_tickets.count
      assert open_tickets == 2, "Returned incorrect number of tickets (#{ open_tickets })."
    end

    should "return an array of all tickets with status 'closed'" do
      create(:ticket, :closed, :low)
      create(:ticket, :closed, :high)

      closed_tickets = Ticket.closed_tickets.count
      assert closed_tickets == 2, "Returned incorrect number of tickets (#{ closed_tickets })."
    end

    should "return an array of all tickets with priority 'low'" do
      create(:ticket, :open, :low)
      create(:ticket, :closed, :low)

      low_priority_tickets = Ticket.low_priority.count
      assert low_priority_tickets == 2, "Returned incorrect number of tickets (#{ low_priority_tickets })."
    end

    should "return an array of all tickets with priority 'medium'" do
      create_list(:ticket, 2, :medium)
      assert Ticket.medium_priority.count == 2, "Returned incorrect number of tickets (#{Ticket.medium_priority.count})."
    end

    should "return an array of all tickets with priority 'high'" do
      create_list(:ticket, 2, :high)
      assert Ticket.high_priority.count == 2, "Returned incorrect number of tickets (#{Ticket.high_priority.count})."
    end

    should "return tickets newest first" do
      t1 = create(:ticket, created_at: 5.days.ago)
      t2 = create(:ticket, created_at: 10.days.ago)

      assert_equal [t1, t2], Ticket.newest_first.to_a
    end

    should "group tickets by status" do
      ticket1 = create(:ticket, :pending, :low)
      ticket2 = create(:ticket, :open, :high)
      ticket3 = create(:ticket, :closed, :low)

      expected_results = {
        pending: [ ticket1 ],
        open: [ ticket2 ],
        closed: [ ticket3 ]
      }.with_indifferent_access

      assert_equal expected_results, Ticket.group_by_status
    end

    context "loading visible tickets" do
      setup do
        @customer = create(:customer)
        @agent = create(:agent)
        @admin = create(:admin)

        @ticket1 = create(:ticket, user_id: 999, agent_id: 888)
        @ticket2 = create(:ticket, user_id: @customer.id, agent_id: @agent.id)
      end

      should "return all tickets for admins" do
        assert_equal [@ticket1, @ticket2].to_set, Ticket.visible(@admin).to_set
      end

      should "return their tickets for customers" do
        assert_equal [@ticket2].to_set, Ticket.visible(@customer).to_set
      end

      should "return assigned tickets for agents" do
        assert_equal [@ticket2].to_set, Ticket.visible(@agent).to_set
      end
    end
  end

  context "A ticket" do
    setup do
      @ticket = create(:ticket)
    end

    should "list comments and version changes as activity" do
      @ticket.update_column(:status, :open)
      create(:comment, ticket: @ticket)

      assert_equal [Comment, PaperTrail::Version].to_set, @ticket.reload.activity.map(&:class).uniq.to_set
    end

    should "set status to 'pending' on create" do
      ticket = create(:ticket)
      assert ticket.status == "pending", "Did not set ticket status to 'pending' on create."
    end
  end

end
