ActionController::Routing::Routes.draw do |map|
  map.resources :invitations, :only => [:index, :new, :create]
  map.resources :opt_outs, :only => [:show, :create]
  
  map.resources :dreams do |dream|
    dream.resources :comments, :only => :create do |comment|
      comment.resources :reports, :only => [:new, :create], :controller => 'comment_reports'
    end
  end

  map.search '/search.:format', :controller => 'search'

  map.namespace :admin do |admin|
    admin.resources :pages
    admin.resources :comments, :dreamers, :except => [:new, :create, :show]
  end
  
  map.resources :dreamers, :shallow => true do |dreamers|
    dreamers.resources :ratings, :only => [:index, :create]
    
    dreamers.resource :credentials, :only => [:edit, :update]

    dreamers.resource :password,
      :controller => 'clearance/passwords',
      :only       => [:create, :edit, :update]

    dreamers.resource :confirmation,
      :controller => 'clearance/confirmations',
      :only       => [:new, :create]
  end
  
  map.resources :ratings, :only => :index
  
  map.sign_up  'sign_up',
    :controller => 'dreamers',
    :action     => 'new'
    
  %W(about history behind where-we-are contact).each do |page|
    map.connect "/#{page}", :controller => 'home', :action => 'page', :permalink => page
  end
  
  map.root :controller => 'home'
end
