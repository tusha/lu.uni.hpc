# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    transaction_id "MyString"
    params "MyString"
    send_money "MyString"
    user_id 1
  end
end
