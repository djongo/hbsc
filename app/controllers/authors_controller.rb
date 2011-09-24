class AuthorsController < ApplicationController
  def index
    @authors = Author.all(:order => "position")
  end
  
  def show
    @author = Author.find(params[:id])
  end
  
  def new
    @author = Author.new
  end
  
  def create
    @author = Author.new(params[:author])
    if @author.save
      flash[:notice] = "Successfully created author."
      redirect_to @author
    else
      render :action => 'new'
    end
  end
  
  def edit
    @author = Author.find(params[:id])
  end
  
  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      flash[:notice] = "Successfully updated author."
      redirect_to @author
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    flash[:notice] = "Successfully destroyed author."
    redirect_to authors_url
  end
  
  def sort
    params[:authors].each_with_index do |id, index|
      Author.update_all(['position=?',index+1], ['id=?', id])
    end
    render :nothing => true
  end
end
