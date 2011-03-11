class PagesController < ApplicationController
#  filter_resource_access
  
  def home
    @title = "Home"
    if current_user
      @publication = Publication.find_all_by_user_id(current_user.id, :order => 'updated_at DESC')
    else
      @user_session = UserSession.new
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
