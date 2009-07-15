ActionController::Routing::Routes.draw do |map|
  map.resources :dreams


  map.resources :dreamers do |dreamers|
    dreamers.resource :password,
      :controller => 'clearance/passwords',
      :only       => [:create, :edit, :update]

    dreamers.resource :confirmation,
      :controller => 'clearance/confirmations',
      :only       => [:new, :create]
  end
  
  map.root :controller => 'home'
end
