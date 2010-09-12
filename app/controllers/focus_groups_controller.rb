class FocusGroupsController < ApplicationController
  filter_resource_access
  
  def index
    @focus_groups = FocusGroup.all
  end
  
  def show
#    @focus_group = FocusGroup.find(params[:id])
  end
  
  def new
#    @focus_group = FocusGroup.new
  end
  
  def create
#    @focus_group = FocusGroup.new(params[:focus_group])
    if @focus_group.save
      flash[:notice] = "Successfully created focus group."
      redirect_to @focus_group
    else
      render :action => 'new'
    end
  end
  
  def edit
#    @focus_group = FocusGroup.find(params[:id])
  end
  
  def update
#    @focus_group = FocusGroup.find(params[:id])
    if @focus_group.update_attributes(params[:focus_group])
      flash[:notice] = "Successfully updated focus group."
      redirect_to @focus_group
    else
      render :action => 'edit'
    end
  end
  
  def destroy
#    @focus_group = FocusGroup.find(params[:id])
    @focus_group.destroy
    flash[:notice] = "Successfully destroyed focus group."
    redirect_to focus_groups_url
  end
end
