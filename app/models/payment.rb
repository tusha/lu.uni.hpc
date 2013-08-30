class Payment < ActiveRecord::Base
   def self.pay(t, payerID, user_id)
    #begin 
      payment=self.find_by_payment_token(t)
      payment.payerid=payerID
      payment.save
      #PaypalWorker.perform_async(payment)      
      @token=Token.find(payment.token_id)    
      
      @paypal=PaypalInterface.new(@token, payment, user_id)
      #logger.info "@paypal"
      @paypal.do_express_checkout
      
      #return payment
    #rescue
      #false
    #end
  end
  
  def self.receive_ipn(id,params)
    begin
      payment=self.find_by_id(id)
      payment.params=params.to_s
      return payment
    rescue
      false
    end    
  end
 
   def self.create_ipn(id,params)
    begin
      payment=self.find_by_id(id)
      payment.params=params.to_s
      return payment
    rescue
      false
    end    
  end
  
  def self.cancel_payment(id,params)
    #begin 
      payment=self.find_by_id(id)
      payment.params=params.to_s
      payment.status="canceled"
      return payment
    #rescue
      #false
    #end
  end
  
  
end
