# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Creating some initial data for the database

# Load languages
["Danish", "English", "French", "German", "Spanish"].each do |language|
  Language.find_or_create_by_name(language)
end

# Load survey data
["83/84","85/86","89/90","93/94","97/98","01/02","05/06","09/10"].each do |survey|
  Survey.find_or_create_by_name(survey)
end

# Load Publication Types
["Journal article","Book","Book chapter"].each do |ptype|
  PublicationType.find_or_create_by_name(ptype)
end

# Load populations
["Denmark","Germany","International","Israel","Norway","Scotland","Spain"].each do |population|
  Population.find_or_create_by_name(population)
end

# Load Country Teams
["Denmark","Germany","Israel","Norway","Scotland","Spain"].each do |ct|
  CountryTeam.find_or_create_by_name(ct)
end

# Load Focus Groups
["SI"].each do |fg|
  FocusGroup.find_or_create_by_name(fg)
end

# Load Target Journals
["International Journal of Public Health","Journal of Adolescent Health","Journal of School Health","International Journal of Clinical and Health Psychology","Journal of Physical Activity and Health"].each do |tj|
  TargetJournal.find_or_create_by_name(tj)
end

# Load admin user
if User.find_by_email('jonasholstein@gmail.com').nil?
  User.create! :email => 'jonasholstein@gmail.com', :password => 'admin123', :password_confirmation => 'admin123', :first_name => "Jonas", :last_name => "Holstein", :roles_mask => "3", :hbsc_member => true  
end

if User.find_by_email('kapu@niph.dk').nil?
  User.create! :email => 'kapu@niph.dk', :password => 'admin123', :password_confirmation => 'admin123', :first_name => "Kaisa", :last_name => "Puhakka", :roles_mask => "3", :hbsc_member => true
end

if User.find_by_email('Ashley.Theunissen@ed.ac.uk').nil?
  User.create! :email => 'Ashley.Theunissen@ed.ac.uk', :password => 'admin123', :password_confirmation => 'admin123', :first_name => "Ashley", :last_name => "Theunissen", :roles_mask => "3", :hbsc_member => true 
end


# Load standard email texts
if Email.find_by_trigger('preplanned_submit').nil?
  Email.create! :trigger => 'preplanned_submit', :subject => 'Publication submission', :content => 'You preplanned publication has been submitted for acceptance as planned.', :delay => 0
end

if Email.find_by_trigger('preplanned_accept').nil?
  Email.create! :trigger => 'preplanned_accept', :subject => 'Publication acceptance', :content => 'You preplanned publication has been acceptance as planned.', :delay => 0
end

if Email.find_by_trigger('preplanned_reject').nil?
  Email.create! :trigger => 'preplanned_reject', :subject => 'Publication rejection', :content => 'You preplanned publication has been rejected as planned.', :delay => 0
end

if Email.find_by_trigger('preplanned_remind').nil?
  Email.create! :trigger => 'preplanned_remind', :subject => 'Publication reminder', :content => 'You preplanned publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('planned_submit').nil?
  Email.create! :trigger => 'planned_submit', :subject => 'Publication submission', :content => 'You planned publication has been submitted for acceptance as in progress.', :delay => 0
end

if Email.find_by_trigger('planned_accept').nil?
  Email.create! :trigger => 'planned_accept', :subject => 'Publication acceptance', :content => 'You planned publication has been acceptance as in progress.', :delay => 0
end

if Email.find_by_trigger('planned_reject').nil?
  Email.create! :trigger => 'planned_reject', :subject => 'Publication rejection', :content => 'You planned publication has been rejected as in progress.', :delay => 0
end

if Email.find_by_trigger('planned_remind').nil?
  Email.create! :trigger => 'planned_remind', :subject => 'Publication reminder', :content => 'You planned publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('inprogress_submit').nil?
  Email.create! :trigger => 'inprogress_submit', :subject => 'Publication submission', :content => 'You in progress publication has been submitted for acceptance as submitted.', :delay => 0
end

if Email.find_by_trigger('inprogress_accept').nil?
  Email.create! :trigger => 'inprogress_accept', :subject => 'Publication acceptance', :content => 'You in progress publication has been acceptance as submitted.', :delay => 0
end

if Email.find_by_trigger('inprogress_reject').nil?
  Email.create! :trigger => 'inprogress_reject', :subject => 'Publication rejection', :content => 'You in progress publication has been rejected as submitted.', :delay => 0
end

if Email.find_by_trigger('inprogress_remind').nil?
  Email.create! :trigger => 'inprogress_remind', :subject => 'Publication reminder', :content => 'You in progress publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('submitted_submit').nil?
  Email.create! :trigger => 'submitted_submit', :subject => 'Publication submission', :content => 'You submitted publication has been submitted for acceptance as accepted.', :delay => 0
end

if Email.find_by_trigger('submitted_accept').nil?
  Email.create! :trigger => 'submitted_accept', :subject => 'Publication acceptance', :content => 'You submitted publication has been acceptance as accepted.', :delay => 0
end

if Email.find_by_trigger('submitted_reject').nil?
  Email.create! :trigger => 'submitted_reject', :subject => 'Publication rejection', :content => 'You submitted publication has been rejected as accepted.', :delay => 0
end

if Email.find_by_trigger('submitted_remind').nil?
  Email.create! :trigger => 'submitted_remind', :subject => 'Publication reminder', :content => 'You submitted publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('accepted_submit').nil?
  Email.create! :trigger => 'accepted_submit', :subject => 'Publication submission', :content => 'You accepted publication has been submitted for acceptance as published.', :delay => 0
end

if Email.find_by_trigger('accepted_accept').nil?
  Email.create! :trigger => 'accepted_accept', :subject => 'Publication acceptance', :content => 'You accepted publication has been acceptance as published.', :delay => 0
end

if Email.find_by_trigger('accepted_reject').nil?
  Email.create! :trigger => 'accepted_reject', :subject => 'Publication rejection', :content => 'You accepted publication has been rejected as published.', :delay => 0
end

if Email.find_by_trigger('accepted_remind').nil?
  Email.create! :trigger => 'accepted_remind', :subject => 'Publication reminder', :content => 'You accepted publication not been updated for a long time.', :delay => 60
end
