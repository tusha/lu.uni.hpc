class AccountsController < ApplicationController
  before_filter :require_user
  before_action :set_account, only: [:show, :edit, :update, :destroy, :index]

  # GET /accounts
  def index
    @account=Account.find_by_user_id(current_user.id)
    if @account.script_url != nil
    @account.script= File.open(@account.script_url, "r") {|io| io.read} 
    end
    render action: 'edit'
  end

  # GET /accounts/1
  def show
     @account=Account.find_by_user_id(current_user.id)
     @account.script= File.open(@account.script_url, "r") {|io| io.read} 
     render action: 'edit'
  end

  # GET /accounts/new
  def new
    if !Account.exists?(:user_id => current_user.id)
      @account = Account.new  
    else  redirect_to action: 'index'
    end
  end

  # GET /accounts/1/edit
  def edit
     @account=Account.find_by_user_id(current_user.id)
     if @account.script_url != nil
      @account.script= File.open(@account.script_url, "r") {|io| io.read} 
     else redirect_to action: 'new'
     end
  end

  # POST /accounts
  def create
   @account = Account.new(account_params)
    
   if !Account.exists?(:user_id=>current_user.id)
     if path=Account.save_file(account_params)
       @account.script_url=path      
       @account.save       
        add_free_tokens(@account)
       @account.script= File.open(@account.script_url, "r") {|io| io.read} 
       render action: 'edit'
     else
       render action: 'new'
     end
   else redirect_to action: 'index'
   end  
  end

  # PATCH/PUT /accounts/1
  def update
    @account.update(account_params) 
     if @account.script_url == nil
       path=Account.save_file(account_params)
       @account.script_url=path      
       @account.save 
     end    
     @account.script= File.open(@account.script_url, "r") {|io| io.read} 
     render action: 'edit'
  end

  # DELETE /accounts/1
  def destroy    
    Account.destoy_file(@account)
    @account.script_name = nil
    @account.script_url = nil
    @account.save
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end 
    
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
        if Account.find_by_user_id(current_user.id)== nil
         redirect_to action: 'new'
      else
       @account = Account.find_by_user_id(current_user.id)
      end
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:script, :script_name, :user_id, :comment)
    end
    
    #add 10 free tokens when register account
    def add_free_tokens(account)
       token=Token.find_by_isdefault(true) 
       account.tokens=[]      
       account.tokens.push([token.id, 10])
       account.save
    end
    
  
end
