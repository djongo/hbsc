class Note < ActiveRecord::Base
  attr_accessible :publication_id, :user_id, :state, :content
  belongs_to :publication
  belongs_to :user
end
