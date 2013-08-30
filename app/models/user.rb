class User < ActiveRecord::Base
 
  acts_as_authentic do |c|
   c.validate_password_field=false
    c.logged_in_timeout=2.minutes
  
  end # block optional
  
  has_one :address
  accepts_nested_attributes_for :address, allow_destroy: true
 
  has_one :account
end
