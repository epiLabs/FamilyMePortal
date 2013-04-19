# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    family_id 1
    user_id 1
    sequence(:email) {|n| "inviteThisOne#{n}@example.com" }
  end
end
