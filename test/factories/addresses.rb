# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    user_id 1
    street "MyString"
    number "MyString"
    city "MyString"
    country "MyString"
    index "MyString"
  end
end
