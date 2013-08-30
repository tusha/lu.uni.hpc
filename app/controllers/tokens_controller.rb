class TokensController < ApplicationController
  before_filter :require_user
  before_action :set_token, only: [:show, :edit, :update, :destroy]

  
  # GET /tokens
  def index    
    @tokens = Token.all    
  end

  # GET /tokens/1
  def show    
    if @current_user.role !='admin'
      buy
    end
  end

  # GET /tokens/new
  def new   
    @token = Token.new
    authorize! :new, @token
  end

  # GET /tokens/1/edit
  def edit
    authorize! :edit, @token
  end

  # POST /tokens
  def create     
    @token = Token.new(token_params)    
    if @token.save
      redirect_to @token, notice: 'Token was successfully created.'
    else
      render action: 'index'
    end
  end

  # PATCH/PUT /tokens/1
  def update   
    authorize! :update, @token
    if @token.update(token_params)
      redirect_to @token, notice: 'Token was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /tokens/1
  def destroy   
    authorize! :destroy, @token
    @token.destroy
    redirect_to tokens_url, notice: 'Token was successfully destroyed.'
  end
  
  
  
  def paid
    if payment=Payment.pay(params[:token], params[:PayerID], current_user.id)        
      redirect_to tokens_path 
      #success message
      
    else
      #error_message
      redirect_to tokens_path
    end
    
    #redirect_to tokens_path
  end
  
  def revoked 
    payment=Payment.find_by_payment_token(params[:token])
    if payment = Payment.cancel_payment(payment.id,params)
      #set a message for the user
     
    end
    redirect_to tokens_path
  end
  
  def ipn
    if p=Payment.find_by_transaction_id(params[:txn_id])
      payment.receive_ipn(p.id, params)
    else
      Payment.create_by_ipn(params)
    end
  end 
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def token_params
      params.require(:token).permit(:quality, :generation_num, :transform_num, :kind, :price, :isdefault)
    end
    
    def buy
    @token=Token.find(params[:id])
    @paypal=PaypalInterface.new(@token, Payment.new, current_user.id)
    @paypal.express_checkout
    if @paypal.express_checkout_response.success?
      @paypal_url=@paypal.api.express_checkout_url(@paypal.express_checkout_response)
    else
      #manage error
    end
  end
  
end
