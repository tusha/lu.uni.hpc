Starterapp::Application.routes.draw do
  
  resources :jobs

  resources :accounts

  resources :supports

  resources :addresses

  resources :users
  match '/users' => 'users#index', via: %i(get), as: :list_users
  get '/view/:id' => 'users#view', via: %i(get), as: :view
  get '/support/new/:id' => 'supports#new', via: %i(get)
 
  match '/auth/:service/callback' => 'services#create', via: %i(get post)#%i(get post)
  match '/auth/failure' => 'services#failure', via: %i(get post)#%i(get post)
  match '/index' => 'pages#index', via: %i(get)

  #resources :services, only: %i(index create destroy)#%i(get)
  root 'pages#index'
  
  resources :user_sessions
  match '/login' => "user_sessions#new", via: %i(get), as: :login 
  match '/logout' => "user_sessions#destroy", via: %i(get delete), as: :logout
  
  resource :user, :as => 'user_profile'  # a convenience route
  
  match '/signed' => 'users#show', via: %i(get), as: :signed
  match '/register' => 'users#create', via: %i(get post), as: :register
  
  match '/profile' => 'profile#index', via: %i(get post), as: :profile
  
  resources :tokens do
    collection do 
      get :paid
      get :revoked
      post :ipn
    end
  end
  
  resources :jobs
  match '/user_tokens' => 'jobs#user_tokens', via: %i(get), as: :user_tokens
  
  
 
  if Rails.env.production?
    HOST_WO_HTTP='www.domain.uni.lu'
  else
    HOST_WO_HTTP='localhost:3000'
  end
  HOST='http://#{HOST_WO_HTTP}'
  
  resources :supports
  match 'supports/create'=>"supports#create", via: %i(post)
  
 
end
