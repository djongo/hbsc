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
    if params[:version]
      @version = @publication.versions.find(params[:version])
      @publication = @version.reify
    end    
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
  
  # Workflow via aasm functions below  
  # locking to avoid concurrency issues, see
  # http://www.engineyard.com/blog/2010/concurrency-and-the-aasm-gem/

  # preplanned to planned
  def submit_planned
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_submit!
    flash[:notice] = "Preplanned submitted for acceptance."
    redirect_to publication_url
  end
  
  def preplanned_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned!
    flash[:notice] = "Publication accepted as planned."
    redirect_to publication_url
  end
  
  def preplanned_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_reject!
    flash[:error] = "Preplanned publication rejected."
    redirect_to publication_url
  end
  
  # planned to inprogress
  def submit_inprogress
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_submit!
    flash[:notice] = "Planned submitted for acceptance."
    redirect_to publication_url
  end
  
  def planned_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress!
    flash[:notice] = "Publication accepted as in progress."
    redirect_to publication_url
  end
  
  def planned_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_reject!
    flash[:error] = "Planned publication rejected."
    redirect_to publication_url
  end    
    
  # inprogress to submitted
  def submit_submitted
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_submit!
    flash[:notice] = "In progress submitted for acceptance."
    redirect_to publication_url
  end
  
  def inprogress_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted!
    flash[:notice] = "Publication accepted as submitted."
    redirect_to publication_url
  end
  
  def inprogress_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_reject!
    flash[:error] = "In progress publication rejected."
    redirect_to publication_url
  end   

  # submitted to accepted
  def submit_accepted
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_submit!
    flash[:notice] = "Submitted submitted for acceptance."
    redirect_to publication_url
  end
  
  def submitted_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted!
    flash[:notice] = "Publication accepted as accepted."
    redirect_to publication_url
  end
  
  def submitted_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_reject!
    flash[:error] = "Submitted publication rejected."
    redirect_to publication_url
  end   

  # accepted to published
  def submit_published
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_submit!
    flash[:notice] = "Accepted submitted for acceptance."
    redirect_to publication_url
  end
  
  def accepted_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.published!
    flash[:notice] = "Accepted accepted as published."
    redirect_to publication_url
  end
  
  def accepted_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_reject!
    flash[:error] = "Accepted publication rejected."
    redirect_to publication_url
  end   
    
end
