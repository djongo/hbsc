class PagesController < ApplicationController
#  filter_resource_access
  
  def home
    @title = "Home"
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
