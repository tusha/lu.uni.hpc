# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    user_id 1
    script_name "MyString"
    script "MyString"
  end
end
