ActionController::Routing::Routes.draw do |map|
  map.resources :user_sessions
  map.resources :users
  map.resources :password_resets, :only => [ :new, :create, :edit, :update ]

  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => "pages", :action => "home"  
  
end
