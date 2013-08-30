class AddressesController < ApplicationController
  before_filter :require_user
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  
  
  # GET /addresses
  def index
    #@addresses = Address.all
    @address = Address.find_by_user_id(current_user.id)
    render action: 'edit'
  end

  # GET /addresses/1
  def show    
    @address=Address.find_by_user_id(current_user.id)
  end

  # GET /addresses/new
  def new
    if !Address.exists?(:user_id =>current_user.id)
      @address = Address.new
    else  redirect_to action: 'index'
    end
  end

  # GET /addresses/1/edit
  def edit
    @address=Address.find_by_user_id(current_user.id)
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    if !Address.exists?(:user_id =>current_user.id)
      if @address.save
        redirect_to @address, notice: 'Address was successfully created.'
      else
        render action: 'new'
      end
    else redirect_to action: 'index'
    end
  end


  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      redirect_to @address, notice: 'Address was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
    redirect_to addresses_url, notice: 'Address was successfully destroyed.'
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      #@address = Address.find(params[:id])
      if Address.find_by_user_id(current_user.id)== nil
         redirect_to action: 'new'
      else
       @address = Address.find_by_user_id(current_user.id)
      end
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit(:user_id, :street, :number, :city, :country_code, :index)
    end
end
