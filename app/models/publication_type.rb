class PublicationType < ActiveRecord::Base
  attr_accessible :name
  has_many :publications
  validates_presence_of :name    
end
