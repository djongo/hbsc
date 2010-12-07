ActionController::Routing::Routes.draw do |map|
  map.resources :emails

  map.resources :target_journals

  map.resources :journals

  map.resources :variables
  map.resources :focus_groups
  map.resources :country_teams
  map.resources :populations
  map.resources :publication_types
  map.resources :surveys
  map.resources :languages
#  map.resources :publications
  map.resources :publications, :member => { :submit_planned => :put,  
                                            :preplanned_accept => :put,
                                            :preplanned_reject => :put, 
                                            :submit_inprogress => :put,  
                                            :planned_accept => :put,
                                            :planned_reject => :put, 
                                            :submit_submitted => :put,  
                                            :inprogress_accept => :put,
                                            :inprogress_reject => :put, 
                                            :submit_accepted => :put,  
                                            :submitted_accept => :put,
                                            :submitted_reject => :put,
                                            :submit_published => :put,  
                                            :accepted_accept => :put,
                                            :accepted_reject => :put
                                            }  
  map.resources :user_sessions
  map.resources :users
  map.resources :password_resets, :only => [ :new, :create, :edit, :update ]

  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.about "/about", :controller => "pages", :action => "about"
  map.contact "/contact", :controller => "pages", :action => "contact"
  map.master "/master", :controller => "pages", :action => "master"  
  map.home "/", :controller => "pages", :action => "home"  
  map.connect 'auto_complete_for_variable_name', :controller => 'publications', :action => 'auto_complete_for_variable_name'
 
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => "pages", :action => "home"  
end
