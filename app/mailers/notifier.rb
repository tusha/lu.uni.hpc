class Notifier < ActionMailer::Base
  default from: "hpc-users@hpc.uni.lu"
  
  def payment_notification(recipient)
    mail(to: recipient.email, 
         subject: recipient.sender_name, 
         body: recipient.content
        )
  end
  
  
end
