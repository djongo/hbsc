namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    [Publication, User, Keyword, Outcome, Determinant, Mediator, Foundation, Variable, Inclusion, Author].each(&:delete_all)
    
    Publication.populate 60 do |publication|
      publication.title = Populator.words(3..7).titleize
      publication.description = Populator.sentences(4..10)
      publication.publication_type_id = (1..3)
      publication.language_id = (1..5)
      publication.user_id = (1..17)
      publication.state = ["preplanned","planned","inprogess","submitted","accepted","published"]
      publication.created_at = 2.years.ago..Time.now
      publication.reference = Populator.words(3..7).titleize
      publication.promotion = ["false","true"]
      publication.responsible_id = (1..17)
#      publication.contact_id = (1..12)
      publication.target_journal_id = (1..4)
      publication.archived = [false,true]
      publication.contact_name = Faker::Name.name
      publication.contact_email = Faker::Internet.email
      Author.populate 2..4 do |author|      
        author.publication_id = publication.id
        author.position = (1..4)
        author.name = Faker::Name.name
        author.email = Faker::Internet.email
        author.country_team_id = (1..6)
        author.focus_group_id = (1..4)
      end
    end

    Variable.populate 80 do |variable|
      variable.name = Populator.words(1)  
    end
    
    Keyword.populate 150 do |keyword|
      keyword.publication_id = (1..60)
      keyword.variable_id = (1..80)
    end

    Outcome.populate 150 do |outcome|
      outcome.publication_id = (1..60)
      outcome.variable_id = (1..80)
    end

    Determinant.populate 150 do |determinant|
      determinant.publication_id = (1..60)
      determinant.variable_id = (1..80)
    end

    Mediator.populate 150 do |mediator|
      mediator.publication_id = (1..60)
      mediator.variable_id = (1..80)
    end

    Foundation.populate 150 do |foundation|
      foundation.publication_id = (1..60)
      foundation.survey_id = (1..8)
    end

    Inclusion.populate 150 do |inclusion|
      inclusion.publication_id = (1..60)
      inclusion.population_id = (1..7)
    end

#    Authorship.populate 150 do |authorship|
#      authorship.publication_id = (1..60)
#      authorship.user_id = (1..11)
#    end
        
    User.populate 10 do |user|
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name      
      user.email = Faker::Internet.email
      user.login_count = (1..10)
      user.failed_login_count = (0..5)
      user.perishable_token = Populator.words(1)
      user.roles_mask = (0..3)
      user.hbsc_member = ["false","true"]
    end
    
  end
end
