class Email < ActiveRecord::Base
  attr_accessible :trigger, :subject, :content
end
