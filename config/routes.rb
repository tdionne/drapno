ActionController::Routing::Routes.draw do |map|
  map.resources :invitations, :only => [:index, :new, :create]
  map.resources :opt_outs, :only => [:show, :create]
  
  map.resources :dreams

  map.search '/search.:format', :controller => 'search'

  map.resources :dreamers do |dreamers|
    dreamers.resource :credentials, :only => [:edit, :update]

    dreamers.resource :password,
      :controller => 'clearance/passwords',
      :only       => [:create, :edit, :update]

    dreamers.resource :confirmation,
      :controller => 'clearance/confirmations',
      :only       => [:new, :create]
  end
  
  map.sign_up  'sign_up',
    :controller => 'dreamers',
    :action     => 'new'
  map.root :controller => 'home'
end
