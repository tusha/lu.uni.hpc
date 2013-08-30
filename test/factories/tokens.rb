# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :token do
    quality "MyString"
    generation_num 1
    transform_num 1
    type ""
    price "9.99"
  end
end
