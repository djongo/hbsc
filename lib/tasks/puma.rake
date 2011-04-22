desc "Send reminders to publication authors"
task :remind => :environment do
  # Find all non-archived publications
  publications = Publication.find(:all, :conditions => ['archived = ? AND state NOT LIKE ?', 'false','%_submitted'])
  publications.each do |p|
    # Find latest entry in reminder table
    r = Reminder.find(:last, :conditions => ['publication_id = ?', p.id])
    # Call method to send reminder if needed
    r.send_reminder(p)
  end
end
