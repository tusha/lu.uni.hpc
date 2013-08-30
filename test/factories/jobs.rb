# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    name "MyString"
    user_id 1
    script_id 1
    tokens ""
    optional_params ""
    output_id 1
  end
end
