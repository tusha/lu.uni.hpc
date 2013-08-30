require 'paypal-sdk-merchant'

class PaypalInterface
  attr_reader :api, :express_checkout_response
  
  PAYPAL_RETURN_URL=Rails.application.routes.url_helpers.paid_tokens_url(host: HOST_WO_HTTP)
  PAYPAL_CANCEL_URL=Rails.application.routes.url_helpers.revoked_tokens_url(host:HOST_WO_HTTP)
  PAYPAL_NOTIFY_URL=Rails.application.routes.url_helpers.ipn_tokens_url(host:HOST_WO_HTTP)
  
  def initialize(token, payment, user_id)
    @api=PayPal::SDK::Merchant::API.new
    @token=token
    payment.token_id=token.id
    payment.user_id=user_id
    payment.save
    @payment=payment
  end
  
  def express_checkout
    @set_express_checkout=@api.build_set_express_checkout({
      SetExpressCheckoutRequestDetails: {
        ReturnURL: PAYPAL_RETURN_URL,
        CancelURL: PAYPAL_CANCEL_URL,
        PaymentDetails: [{
          NotifyURL: PAYPAL_NOTIFY_URL,
          OrderTotal: {
            currencyID: "EUR",
            value: @token.price
          },
          TaxTotal:{
            currencyID:"EUR",
            value: "0"
          },
          PaymentDetailsItem: [{
            Name: "token_gen_"+@token.generation_num.to_s + "_transf_"+@token.transform_num.to_s+ "_"+@token.kind,
            Quantity: 1,
            Amount: {
              currencyID: "EUR",
              value: @token.price
            },
            ItemCategory: "Digital"            
          }],
          PaymentAction: "Sale"
        }]
      }
    })
    
    #Make API call and get response
    @express_checkout_response=@api.set_express_checkout(@set_express_checkout)
    
    #Access response
    if @express_checkout_response.success?
      @payment.payment_token=@express_checkout_response.Token
      @payment.save
    else
      @express_checkout_response.Errors
    end    
  end
  
  def do_express_checkout
    @do_express_checkout_payment = @api.build_do_express_checkout_payment({
      DoExpressCheckoutPaymentRequestDetails: {
        PaymentAction: "Sale",
        Token: @payment.payment_token,
        PayerID: @payment.payerid,
        PaymentDetails: [{
          OrderTotal: {
            currencyID: "EUR",
            value: @token.price
          },
          NotifyURL: PAYPAL_NOTIFY_URL
        }]
      }
    })

    # Make API call & get response
    @do_express_checkout_payment_response = @api.do_express_checkout_payment(@do_express_checkout_payment)

    # Access Response
    if @do_express_checkout_payment_response.success?
      details = @do_express_checkout_payment_response.DoExpressCheckoutPaymentResponseDetails
      @payment.params=details.PaymentInfo.to_s     
      @payment.status=@do_express_checkout_payment_response.Ack
      add_tokens(@token.id, 1)
      notify_user(@payment.user_id)      
     # @payment.transaction_id=@payment.params[0].to_s
      @payment.save
       
    else
      errors = @do_express_checkout_payment_response.Errors # => Array
      @payment.error=errors.to_s
      @payment.status="error"
      @payment.save
    end
  end  
  
  private 
  def notify_user(user_id)
    user=User.find_by_id(user_id)
    support= Support.new
    support.email=user.email
    support.sender_name="HPC@Uni.lu PayPal notification"
  
    support.content="PayPal payment item: token type '"+ @token.quality+ "' price: "+ @token.price.to_s+ " €" +'
  
------------------------------------
The HPC Sysadmins team 

 
Research Associate, UL HPC platform manager
ILIAS - CSC (University of Luxembourg)
Campus Kirchberg
 

hpc-sysadmins@uni.lu
http://www.hpc.uni.lu/
 
-----
This message is confidential and may contain privileged information. It is intended for the named recipient only. If you receive it in error please notify me and permanently delete the original message and any copies.
-----'
    Notifier.payment_notification(support).deliver!
  end
  
  def add_tokens(token_id, amount)
    Account.add_user_tokens(@payment.user_id, token_id, amount)   
  end
  
  
end
