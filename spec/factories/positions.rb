# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    trait :valid_coordinates do
      sequence(:latitude) {|n| Random.rand(90) }
      sequence(:longitude) {|n| Random.rand(180) }
    end
  end
end
