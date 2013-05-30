FactoryGirl.define do
  factory :event do
    title "Some event"
    description "My description"
    user_id 1
    family_id 1
    start_date Time.now
    end_date (Time.now + 2.hours)
  end
end
