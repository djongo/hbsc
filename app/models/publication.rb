class Publication < ActiveRecord::Base
  attr_accessible :title, :description, :language_id, :publication_type_id
  belongs_to :language
  belongs_to :publication_type
#  include AASM
end
