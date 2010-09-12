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

# Load admin user
if User.find_by_email('jonasholstein@gmail.com').nil?
  User.create! :email => 'jonasholstein@gmail.com', :password => 'admin123', :password_confirmation => 'admin123', :first_name => "Jonas", :last_name => "Holstein", :roles_mask => "3"  
end


