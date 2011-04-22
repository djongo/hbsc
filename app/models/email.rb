class Email < ActiveRecord::Base
  attr_accessible :trigger, :subject, :content, :delay
  validates_presence_of :delay
  validates_numericality_of :delay, :only_integer => true
  # Removed, so 0 can be used to stop reminders., :greater_than => 0
end
