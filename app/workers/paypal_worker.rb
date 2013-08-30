class PaypalWorker
  include Sidekiq::Worker
  
  def perform(payment)
    @token=Token.find(payment.token_id)    
    @paypal=PaypalInterface.new(@token, payment)
 
    @paypal.do_express_checkout    
  end
end