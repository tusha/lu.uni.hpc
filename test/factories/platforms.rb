# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :platform do
    date "2013-07-29 17:03:17"
    name "MyString"
    nodes_num 1
    cores_num 1
    cores_free 1
    cores_used 1
    cores_reserved 1
    cores_suspended 1
    status "MyString"
  end
end
