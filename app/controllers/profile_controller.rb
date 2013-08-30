class ProfileController <ApplicationController
  def index
    edit_user_path(current_user.id)
  end
  
  def address
    render "address/edit"
  end
  
  def account
    
  end
  
end