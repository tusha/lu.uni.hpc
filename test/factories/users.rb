# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname "MyString"
    lastname "MyString"
    username "MyString"
    kind "MyString"
    email "MyString"
    phonenumber "MyString"
    mobile "MyString"
    password_salt "MyString"
    id_account 1
    id_address 1
    isactive false
    loginretries 1
    secretquestion "MyString"
    secretanswer "MyString"
    lastlogindate "2013-08-05 17:02:45"
    persistence_token "MyString"
    crypted_password "MyString"
    role "MyString"
  end
end
