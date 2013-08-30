class UserSession < Authlogic::Session::Base
  generalize_credentials_error_messages "Login/password invaild"    
   logout_on_timeout
   
   def self.sweep(time = 1.hour)
    if time.is_a?(String)
      time = time.split.inject { |count, unit| count.to_i.send(unit) }
    end
  delete_all "updated_at < '#{time.ago.to_s(:db)}'" 
  end
end
