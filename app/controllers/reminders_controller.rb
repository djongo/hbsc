class RemindersController < ApplicationController
  def index
    @reminders = Reminder.all
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
