class UsersController < ApplicationController  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :destroy]
  #load_and_authorize_resource
  
   def index   
     @support=Support.new(:id=>1)
    @users = User.all
    authorize! :index, @users
  end
  
   def new
    if(require_no_user)
      @user = User.new
      
    else
      @user=current_user
      flash[:notice] = "You are already registered!"
    end
    @user.lastlogindate=Date.today.to_s
    @user.isactive=true
  end

  def create
    if(require_no_user)
      @user = User.new(user_params)

      # Saving without session maintenance to skip
      # auto-login which can't happen here because
      # the User has not yet been activated
        if @user.save
          flash[:notice] = "Your account has been created."
          redirect_to signed_url
        else
          flash[:notice] = "There was a problem creating your account."
          render :action => :new
        end
     else
      @user=current_user
      flash[:notice] = "You are already registered!"    
    end

  end

# GET /users/1
  def show
   @user=current_user      
  end 
  
# GET /users/1  
  def view
    @user = User.find(params[:id])
    render :action => :show
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user 
    if @user.update_attributes(user_params)
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
   def destroy   
     @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: 'User was successfully deleted.'
  end
  
  def email
    redirect_to 'supports/new' 
  end
  
     # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :username, :kind, :email, :phonenumber, :mobile, :password, :id_account, :secretquestion, :secretanswer, :persistence_token, :crypted_password)
    end    
  
end

 
