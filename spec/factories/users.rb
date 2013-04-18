# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"

    trait :in_new_family do
      sequence(:family_id) {|n| n }
    end
  end
end
