class Ability
  include CanCan::Ability
  
  def initialize(user)    
    user ||= User.new
    
      if user.role == 'admin'
        can :manage, :all     
        cannot [:update, :create], User
        cannot [:buy], Token
      else 
       cannot [:manage, :create, :destroy, :update], Token    
       can :buy, Token
       cannot :create, User
       can :manage, UserSession
      
    end
  end
end