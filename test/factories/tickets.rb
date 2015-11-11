FactoryGirl.define do
  factory :ticket do
    user_id 1
    agent_id 1

    subject "Having trouble"
    body "Hello, I'm having trouble creating an account, thanks :)"

    trait :low do
      priority "low"
    end

    trait :medium do
      priority "medium"
    end

    trait :high do
      priority "high"
    end

    trait :pending do
      status "pending"
    end

    trait :open  do
      status "open"
    end

    trait :closed do
      status "closed"
    end
  end
end
