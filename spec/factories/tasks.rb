# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do

    trait :valid do
      title "Some random name"
      user_id 1
      finished false
    end
  end
end
