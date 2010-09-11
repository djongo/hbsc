class PublicationsController < ApplicationController
  filter_resource_access
  # above loads current publication
  
  def index
    @publications = Publication.all
  end
  
  def show
#    @publication = Publication.find(params[:id])
  end
  
  def new
 #   @publication = Publication.new
  end
  
  def create
  #  @publication = Publication.new(params[:publication])
    if @publication.save
      flash[:notice] = "Successfully created publication."
      redirect_to @publication
    else
      render :action => 'new'
    end
  end
  
  def edit
#    @publication = Publication.find(params[:id])
  end
  
  def update
#    @publication = Publication.find(params[:id])
    if @publication.update_attributes(params[:publication])
      flash[:notice] = "Successfully updated publication."
      redirect_to @publication
    else
      render :action => 'edit'
    end
  end
  
  def destroy
 #   @publication = Publication.find(params[:id])
    @publication.destroy
    flash[:notice] = "Successfully destroyed publication."
    redirect_to publications_url
  end
end
