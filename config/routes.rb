ActionController::Routing::Routes.draw do |map|
  map.resources :authors, :collection => { :sort => :post }
  map.resources :reminders
  map.resources :notes
  map.resources :emails
  map.resources :target_journals
  map.resources :journals
  map.resources :pages
  map.resources :variables
  map.resources :focus_groups
  map.resources :country_teams
  map.resources :populations
  map.resources :publication_types
  map.resources :surveys
  map.resources :languages
#  map.resources :publications
    map.resources :publications, :member => { 
                                            :preplanned_submit => :put,  
                                            :preplanned_accept => :put,
                                            :preplanned_reject => :put, 
                                            :preplanned_remind => :put,
                                            :planned_submit => :put,  
                                            :planned_accept => :put,
                                            :planned_reject => :put, 
                                            :planned_remind => :put,
                                            :inprogress_submit => :put,  
                                            :inprogress_accept => :put,
                                            :inprogress_reject => :put, 
                                            :inprogress_remind => :put,
                                            :submitted_submit => :put,  
                                            :submitted_accept => :put,
                                            :submitted_reject => :put,
                                            :submitted_remind => :put,
                                            :accepted_submit => :put,  
                                            :accepted_accept => :put,
                                            :accepted_reject => :put,
                                            :accepted_remind => :put,
                                            :archive => :put,
                                            :unarchive => :put,
                                            :audit => :get
                                            }, 
                            :collection =>  { 
                                            :list => :get,
                                            :filter => :get
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
 
  map.connect 'auto_complete_for_target_journal_name', :controller => 'publications', :action => 'auto_complete_for_target_journal_name'


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => "pages", :action => "home"  
end
