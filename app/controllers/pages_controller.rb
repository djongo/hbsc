class PagesController < ApplicationController
#  filter_resource_access
  
  def index
    @pages = Page.all
  end

  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      redirect_to pages_url
    else
      render :action => 'edit'
    end
  end  
  
  def home
    @title = "Home"
    @page = Page.find_by_title('home')
    
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
    @page = Page.find_by_title('about')
  end

  def contact
    @title = "Contact"
    @page = Page.find_by_title('contact')    
  end

  def master
    @title = "Master data"
    @page = Page.find_by_title('master data')
  end

end
