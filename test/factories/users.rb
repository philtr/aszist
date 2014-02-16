FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password "test123"
    password_confirmation { password }


    factory(:customer) { role 'customer' }
    factory(:agent) { role 'agent' }
    factory(:admin) { role 'admin' }
  end
end
