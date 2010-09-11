class Publication < ActiveRecord::Base
  attr_accessible :title, :description, :language_id, :publication_type_id
end
