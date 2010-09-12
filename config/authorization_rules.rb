authorization do

  role :guest do
    has_permission_on :publications, :to => [:index, :show]
    has_permission_on :user, :to => [:read, :update] 
    has_permission_on :pages, :to => [:home, :about, :contact]
    # add check for current user only!
  end

  role :author do
    includes :guest
    has_permission_on :publications, :to => [:edit, :update]
#     do 
#      if_attribute :user => is { user }
#    end
    has_permission_on :variables, :to => [:new,:create]
    has_permission_on :publications, :to => [:auto_complete_for_variable_name]
  end
  
  role :publication_group do
    has_permission_on :users, :to => :manage
    has_permission_on :publications, :to => :manage
    has_permission_on :languages, :to => :manage
    has_permission_on :surveys, :to => :manage
    has_permission_on :publication_types, :to => :manage
    has_permission_on :populations, :to => :manage
    has_permission_on :country_teams, :to => :manage
    has_permission_on :focus_groups, :to => :manage    
    has_permission_on :variables, :to => :manage
    has_permission_on :outcomes, :to => :manage
    has_permission_on :mediators, :to => :manage            
    has_permission_on :determinants, :to => :manage
    has_permission_on :authorships, :to => :manage    
    has_permission_on :pages, :to => [:home, :contact, :about, :master]
    has_permission_on :publications, :to => [:auto_complete_for_variable_name]    
  end
end

privileges do
  privilege :manage do
    includes :create, :new, :edit, :update, :destroy, :index, :show
  end
end
