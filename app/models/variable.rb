class Variable < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :keywords
  has_many :publications, :through => :keywords
end
