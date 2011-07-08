require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "should not save without a user" do
    @ticket = tickets(:one)
    @ticket.agent = users(:agent_one)
    assert !@ticket.save, "Saved without a user."
  end

  test "should set status to 'pending' on create" do
    @ticket = tickets(:one)
    @ticket.user = users(:user_one)
    @ticket.agent = users(:agent_one)
    @ticket.save
    assert @ticket.status == "pending",
      "Did not set ticket status to 'pending' on create."
  end

  test "should not save if the status is not in the list" do
    @ticket = tickets(:one)
    @ticket.user = users(:user_one)
    @ticket.agent = users(:agent_one)
    @ticket.status = "forgotten"
    assert !@ticket.save, "Saved with a status not in the list."
  end

end
