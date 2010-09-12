class PublicationsController < ApplicationController
#  filter_resource_access
  filter_access_to :all
  
  auto_complete_for :variable, :name
  # above loads current publication
  
  def index
    @publications = Publication.all
    @per_page = params[:per_page] || 5

    if(params[:search]).blank?
      @publications = Publication.all.paginate(:page => params[:page], :per_page => @per_page, :order => 'title')
    else
      @publications = Publication.with_query(params[:search]).paginate( :page => params[:page], :per_page => @per_page, :order => 'title')
    end
 
  end
  
  def show
    @publication = Publication.find(params[:id])
  end
  
  def new
    @publication = Publication.new
  end
  
  def create
    @publication = Publication.new(params[:publication])
    if @publication.save
      flash[:notice] = "Successfully created publication."
      redirect_to @publication
    else
      render :action => 'new'
    end
  end
  
  def edit
    @publication = Publication.find(params[:id])
  end
  
  def update
    @publication = Publication.find(params[:id])
    if @publication.update_attributes(params[:publication])
      flash[:notice] = "Successfully updated publication."
      redirect_to @publication
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy
    flash[:notice] = "Successfully destroyed publication."
    redirect_to publications_url
  end
end
