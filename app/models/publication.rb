class Publication < ActiveRecord::Base
  attr_accessible :title, :description, :language_id, :publication_type_id
  belongs_to :language
  belongs_to :publication_type
  has_many :keywords
  has_many :variables, :through => :keywords
  accepts_nested_attributes_for :keywords,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['variable_name'].blank? }

end
