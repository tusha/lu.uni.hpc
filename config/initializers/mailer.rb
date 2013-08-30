ActionMailer::Base.delivery_method=:smtp
ActionMailer::Base.perform_deliveries = true

ActionMailer::Base.smtp_settings={
  :enable_starttls_auto => true,
  #:openssl_verify_mode => 'none',
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'localhost:3000',
  :user_name => "hpc.team.test@gmail.com",
  :password =>'hpctest123',
  :authentication => :plain  
}
