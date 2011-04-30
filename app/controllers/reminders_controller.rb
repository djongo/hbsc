class RemindersController < ApplicationController
  def index
    @search = Reminder.search(params[:search])
    @reminders = @search.all
  end
  
  def new
    @reminder = Reminder.new
  end
  
  def create
    @reminder = Reminder.new(params[:reminder])
    if @reminder.save
      flash[:notice] = "Successfully created reminder."
      redirect_to reminders_url
    else
      render :action => 'new'
    end
  end

end
