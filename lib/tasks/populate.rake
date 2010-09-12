namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    [Publication, User, Keyword, Variable].each(&:delete_all)
    
    Publication.populate 60 do |publication|
      publication.title = Populator.words(3..7).titleize
      publication.description = Populator.sentences(4..10)
      publication.publication_type_id = (1..3)
      publication.language_id = (1..5)
      publication.user_id = (1..12)
      publication.created_at = 2.years.ago..Time.now
    end

    Variable.populate 80 do |variable|
      variable.name = Populator.words(1)  
    end
    
    Keyword.populate 180 do |keyword|
      keyword.publication_id = (1..60)
      keyword.variable_id = (1..80)
    end
        
    User.populate 10 do |user|
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name      
      user.email = Faker::Internet.email
      user.login_count = (1..10)
      user.failed_login_count = (0..5)
      user.perishable_token = Populator.words(1)
#      user.password = "test" 
#      user.password_confirmation = "test"
      user.roles_mask = (0..3)
    end
  end
end
