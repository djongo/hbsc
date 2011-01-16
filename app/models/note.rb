class Note < ActiveRecord::Base
  attr_accessible :publication_id, :user_id, :state, :content
  belongs_to :publication
  belongs_to :user
  validates_presence_of :publication_id, :user_id, :state, :content

  # Need note_state because publication has state field
  
  def note_state
    state
  end
  
  def note_state=(input)
    self.state = input
  end
  
end
