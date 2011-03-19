class PagesController < ApplicationController
#  filter_resource_access
  
  def home
    @title = "Home"
    
    # if user is logged in show all user's publications
    if current_user
      @publication = Publication.find_all_by_user_id(current_user.id, :order => 'updated_at DESC', :conditions => ['archived = ?', false])
    else # user not logged in so begin login
      @user_session = UserSession.new
    end
    
    # if user is in publication group show all publications ready for 
    # acceptance or rejection
    if current_user && current_user.roles.include?("publication_group")
      @pending = Publication.find(:all, :conditions => ['state LIKE ? AND archived = ?', "%_submitted", false], :order => 'updated_at DESC')
    end
    
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

  def master
    @title = "Master data"
  end

end
