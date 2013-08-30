class PaymentsController < ApplicationController
  def index
  end

  def confirm
  end

  def complete
  end
  
  def checkout
    setup_response=gateway.setup_purchase(5000,
    :ip => request.remote_ip,
    :return_url => url_for(:action =>'confirm', :only_path =>false),
    :cancel_return_url => url_for(:action=>'index', :only_path=>false)
    )
    redirect_to gateway.redirect_url_for(setup_reponse.token)
  end
  
  private
  def gateway
    @gateway ||= ActiveMerchant::Billing::PaypalExpressGateway.new(
    :login => 'tushis-facilitator_api1.mail.ru',
    :password => '1375445439',
    :signature => 'AFcWxV21C7fd0v3bYYYRCpSSRl31AQO9OveMy-9yQHVPO3hprcaysJs0')
  end
end
