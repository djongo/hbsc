class Contact < ActiveRecord::Base
  attr_accessible :publication_id, :name, :email
  belongs_to :publication  
end
