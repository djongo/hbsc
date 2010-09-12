class UsersController < ApplicationController
  filter_resource_access
  
  def index
#    @users = User.all
    @per_page = params[:per_page] || 15
    @users = User.paginate( :per_page => @per_page, :page => params[:page] )
  
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
#    @user = User.find(params[:id])
     @user = current_user
  end
  
  def update
#    @user = User.find(params[:id])
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
#    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end
end
