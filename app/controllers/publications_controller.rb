class PublicationsController < ApplicationController
#  filter_resource_access
  filter_access_to :all
  
  auto_complete_for :variable, :name
  # above loads current publication
  
  def index
    # , :conditions => ['archived = ?', false] ensures that the indes
    # never shows publications that are archived
    
    @publications = Publication.find(:all, :conditions => ['archived = ?', false])
    @per_page = params[:per_page] || 5

    if(params[:search]).blank?
      @publications = Publication.paginate(:page => params[:page], :per_page => @per_page, :order => 'title', :conditions => ['archived = ?', false])
    else
      @publications = Publication.with_query(params[:search]).paginate(:page => params[:page], :per_page => @per_page, :order => 'title', :conditions => ['archived = ?', false])
    end
    
    if @publications.empty?
      flash[:error] = "No publications matched your search criteria."
    end
    
 
  end
  
  def list
    @publications = Publication.all
  end
  
  def archive
    @publication = Publication.find(params[:id])
    @publication.update_attribute :archived, true
    flash[:notice] = "Publication archived."
    redirect_to list_publications_path
  end
  
  def unarchive
    @publication = Publication.find(params[:id])
    @publication.update_attribute :archived, false
    flash[:notice] = "Publication removed from archive to active status."
    redirect_to list_publications_path    
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
    if @publication.state == "preplanned_submitted" || @publication.state == "planned_submitted" || @publication.state == "inprogress_submitted" || @publication.state == "submitted_submitted" || @publication.state == "accepted_submitted"
      flash[:error] = "Publication has been submitted and cannot be edited."
      redirect_to @publication
    end
    if @publication.archived 
      flash[:error] = "Publication is archived and cannot be edited."
      redirect_to @publication
    end
  end
  
  def update
    @publication = Publication.find(params[:id])
    if @publication.update_attributes(params[:publication])
      flash[:notice] = "Successfully updated publication. Please note that this did not submit the publication for review."
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
    flash[:notice] = "Preplanned submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('submit_planned')
    Notifier.deliver_workflow_notification(@publication.user,@email)
    redirect_to publication_url
  end
  
  def preplanned_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned!
    flash[:notice] = "Publication accepted as planned. Email sent to the author."
    @email = Email.find_by_trigger('preplanned_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email)
    redirect_to publication_url
  end
  
  def preplanned_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_reject!
    flash[:error] = "Preplanned publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('preplanned_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email)  
    redirect_to publication_url
  end
  
  def preplanned_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_remind!
    @email = Email.find_by_trigger('preplanned_remind')    
    Notifier.deliver_workflow_notification(@publication.user,@email)  
  end

  # planned to inprogress
  def submit_inprogress
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_submit!
    flash[:notice] = "Planned submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('submit_inprogress')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end
  
  def planned_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress!
    flash[:notice] = "Publication accepted as in progress. Email sent to the author."
    @email = Email.find_by_trigger('planned_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end
  
  def planned_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_reject!
    flash[:error] = "Planned publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('planned_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end    
    
  # inprogress to submitted
  def submit_submitted
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_submit!
    flash[:notice] = "In progress submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('submit_submitted')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end
  
  def inprogress_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted!
    flash[:notice] = "Publication accepted as submitted. Email sent to the author."
    @email = Email.find_by_trigger('inprogress_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end
  
  def inprogress_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_reject!
    flash[:error] = "In progress publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('inprogress_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end   

  # submitted to accepted
  def submit_accepted
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_submit!
    flash[:notice] = "Submitted submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('submit_accepted')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end
  
  def submitted_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted!
    flash[:notice] = "Publication accepted as accepted. Email sent to the author."
    @email = Email.find_by_trigger('submitted_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end
  
  def submitted_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_reject!
    flash[:error] = "Submitted publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('submitted_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end   

  # accepted to published
  def submit_published
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_submit!
    flash[:notice] = "Accepted submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('submit_published')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end
  
  def accepted_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.published!
    flash[:notice] = "Accepted accepted as published. Email sent to the author."
    @email = Email.find_by_trigger('accepted_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end
  
  def accepted_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_reject!
    flash[:error] = "Accepted publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('accepted_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email)     
    redirect_to publication_url
  end   
    
end
