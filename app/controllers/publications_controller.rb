class PublicationsController < ApplicationController
#  filter_resource_access
  filter_access_to :all
  
  auto_complete_for :variable, :name
  auto_complete_for :target_journal, :name
  # above loads current publication
  helper_method :sort_column, :sort_direction
  
  def index
    # , :conditions => ['archived = ?', false] ensures that the index
    # never shows publications that are archived
    
    @publications = Publication.find(:all, :conditions => ['archived = ?', false])
    @per_page = params[:per_page] || 5

    if(params[:search]).blank?
      @publications = Publication.paginate(:page => params[:page], :per_page => @per_page, :order => 'title', :conditions => ['archived = ?', false])
    else
      @publications = Publication.with_query(params[:search]).paginate(:page => params[:page], :per_page => @per_page, :order => 'title', :conditions => ['archived = ?', false])
    end
    # No match for your search criteria    
    if @publications.empty?
      flash[:error] = "No publications matched your search criteria."
    end
  end
  
  # action for advanced search
  def filter
    @per_page = params[:per_page] || 5    
    @search = Publication.searchlogic(params[:search])
    @pcount = @search.all.count
    @publications = @search.all.paginate(:page => params[:page], :per_page => @per_page)
  end
  
  def list
    @publications = Publication.find(:all, :order => [sort_column, ' ', sort_direction]).paginate(:per_page => 15, :page => params[:page])
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
    if (@publication.state == "preplanned_submitted" || @publication.state == "planned_submitted" || @publication.state == "inprogress_submitted" || @publication.state == "submitted_submitted" || @publication.state == "accepted_submitted") && !current_user.roles.include?("publication_group")
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
  
  def audit
    @publication = Publication.find(params[:id]) 
  end
  
  # Workflow via aasm functions below  
  # locking to avoid concurrency issues, see
  # http://www.engineyard.com/blog/2010/concurrency-and-the-aasm-gem/

  # preplanned to planned
  def preplanned_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_submit!
    flash[:notice] = "Preplanned submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('preplanned_submit')
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def preplanned_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_accept!
    flash[:notice] = "Publication accepted as planned. Email sent to the author."
    @email = Email.find_by_trigger('preplanned_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def preplanned_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_reject!
    flash[:error] = "Preplanned publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('preplanned_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)  
    redirect_to publication_url
  end
  
  def preplanned_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_remind!
    @email = Email.find_by_trigger('preplanned_remind')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)  
    flash[:notice] = "Pre planned publication first author reminder sent."
    redirect_to list_publications_path       
  end

  # planned to inprogress
  def planned_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_submit!
    flash[:notice] = "Planned submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('planned_submit')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)    
    redirect_to publication_url
  end
  
  def planned_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_accept!
    flash[:notice] = "Publication accepted as in progress. Email sent to the author."
    @email = Email.find_by_trigger('planned_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def planned_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_reject!
    flash[:error] = "Planned publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('planned_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end    

  def planned_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_remind!
    @email = Email.find_by_trigger('planned_remind')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    flash[:notice] = "Planned publication first author reminder sent."
    redirect_to list_publications_path    
  end
      
  # inprogress to submitted
  def inprogress_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_submit!
    flash[:notice] = "In progress submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('inprogress_submit')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def inprogress_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_accept!
    flash[:notice] = "Publication accepted as submitted. Email sent to the author."
    @email = Email.find_by_trigger('inprogress_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def inprogress_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_reject!
    flash[:error] = "In progress publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('inprogress_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end   

  def inprogress_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_remind!
    @email = Email.find_by_trigger('inprogress_remind')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    flash[:notice] = "In progress publication first author reminder sent."
    redirect_to list_publications_path    
  end    

  # submitted to accepted
  def submitted_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_submit!
    flash[:notice] = "Submitted submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('submitted_submit')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def submitted_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_accept!
    flash[:notice] = "Publication accepted as accepted. Email sent to the author."
    @email = Email.find_by_trigger('submitted_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def submitted_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_reject!
    flash[:error] = "Submitted publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('submitted_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end   

  def submitted_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_remind!
    @email = Email.find_by_trigger('submitted_remind')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    flash[:notice] = "Submitted publication first author reminder sent."
    redirect_to list_publications_path      
  end 

  # accepted to published
  def accepted_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_submit!
    flash[:notice] = "Accepted submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('accepted_submit')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def accepted_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_accept!
    flash[:notice] = "Accepted accepted as published. Email sent to the author."
    @email = Email.find_by_trigger('accepted_accept')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end
  
  def accepted_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_reject!
    flash[:error] = "Accepted publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('accepted_reject')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    redirect_to publication_url
  end   

  def accepted_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_remind!
    @email = Email.find_by_trigger('accepted_remind')    
    Notifier.deliver_workflow_notification(@publication.user,@email,@publication)
    flash[:notice] = "Accepted publication first author reminder sent."  
    redirect_to list_publications_path    
  end 

  private
  
  def sort_column
    Publication.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

    
end
