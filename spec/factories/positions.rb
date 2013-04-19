# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    trait :valid_coordinates do
      latitude 42
      longitude 55
    end
  end
end
