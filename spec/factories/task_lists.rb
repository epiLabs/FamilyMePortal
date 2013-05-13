# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_list do
    title "MyString"
    description "MyText"
    author_id 1
  end
end
