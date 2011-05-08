class TargetJournalsController < ApplicationController

  def index
    @target_journals = TargetJournal.all
  end
  
  def show
    @target_journal = TargetJournal.find(params[:id])
  end
  
  def new
    @target_journal = TargetJournal.new
  end
  
  def create
    @target_journal = TargetJournal.new(params[:target_journal])
    if @target_journal.save
      flash[:notice] = "Successfully created target journal."
      redirect_to @target_journal
    else
      render :action => 'new'
    end
  end
  
  def edit
    @target_journal = TargetJournal.find(params[:id])
  end
  
  def update
    @target_journal = TargetJournal.find(params[:id])
    if @target_journal.update_attributes(params[:target_journal])
      flash[:notice] = "Successfully updated target journal."
      redirect_to @target_journal
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @target_journal = TargetJournal.find(params[:id])
    @target_journal.destroy
    flash[:notice] = "Successfully destroyed target journal."
    redirect_to target_journals_url
  end
end
