Drapno::Application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :services
  # resources :oauth_consumers, :member => { :callback => :get }, :controller => 'services'
  #
  # resource :facebook_dreamer, :member => { :remove => :get }

  resources :invitations, :only => [:index, :new, :create]
  resources :opt_outs, :only => [:show, :create, :destroy]
  resources :tags, :only => [:show]
  
  resources :dreams do
    resources :comments, :only => :create do
      resources :reports, :only => [:new, :create], :controller => 'comment_reports'
    end
  end

  controller :search do
    get '/search(.:format)', :to => 'search#index', :as => 'search'
  end


  namespace :admin do
    resources :pages
    resources :comments
    resources :dreamers, :except => [:new, :create, :show]
    # get '/dashboard', :controller => 'dashboard'
  end
  
  resources :dreamers do
    resources :follows, :only => [:create, :destroy]
    resources :ratings, :only => [:index, :create]
    
    resource :credentials, :only => [:edit, :update]

    # resource :password,
    #   :controller => :passwords
    #   :only       => [:create, :edit, :update]
    #
    # resource :confirmation,
    #   :controller => 'clearance/confirmations',
    #   :only       => [:new, :create]
  end
  
  resources :ratings, :only => :index
  resources :comments, :only => :index
  resources :follows, :only => :index

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  controller :dreamers do
    get '/sign_up', :action => :new
  end


  %W(about history behind where-we-are contact).each do |page|
    get "/#{page}", :controller => 'home', :action => 'page', :permalink => page
  end
  #
  # ping '/ping', :controller => 'pings', :action => 'ping'
  root :to => 'home#index'
end
