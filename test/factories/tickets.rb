FactoryGirl.define do
  factory :ticket do
    user_id 1
    agent_id 1

    subject "Having trouble"
    body "Hello, I'm having trouble creating an account, thanks :)"

    factory :low_priority_ticket do
      priority "low"

      factory :ticket_pending_low do
        status "pending"
      end

      factory :ticket_open_low  do
        status "open"
      end

      factory :ticket_closed_low do
        status "closed"
      end
    end

    factory :medium_priority_ticket do
      priority "medium"
    end

    factory :high_priority_ticket do
      priority "high"

      factory :ticket_pending_high do
        status "pending"
      end

      factory :ticket_open_high do
        status "open"
      end

      factory :ticket_closed_high do
        status "closed"
      end
    end
  end
end
