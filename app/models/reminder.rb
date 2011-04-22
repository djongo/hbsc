class Reminder < ActiveRecord::Base
  attr_accessible :publication_id, :state, :action, :last_email_at
  belongs_to :publication  

  # Need reminder_state because publication has state field
  
  def reminder_state
    state
  end
  
  def reminder_state=(input)
    self.state = input
  end      

  # Method to send reminder to author
  # usually called from rake tast remind (lib/puma.rake)
  def send_reminder(publication)
    # Check that publication is not submitted
    if !publication.state.include? "_submitted" 
      email = Email.find_by_trigger("#{publication.state}_remind")  
      # Check that delay is set
      if email.delay.days > 0
        # Check if update since last
        if publication.updated_at > self.last_email_at
          Reminder.create(:publication_id => publication.id, :state => publication.state, :action => 'updated', :last_email_at => publication.updated_at)
        # Check if more time than delay has gone
        elsif Time.now > self.last_email_at +  email.delay.days
          # Send out email
          Notifier.deliver_workflow_notification(publication.user,email)  
          Reminder.create(:publication_id => publication.id, :state => publication.state, :action => 'reminded', :last_email_at => publication.updated_at)
        end
      end
    end
  end
  
end
