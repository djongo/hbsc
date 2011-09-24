class Author < ActiveRecord::Base
 attr_accessible :publication_id, :name, :email, :country_team_id, :focus_group_id, :position
  belongs_to :publication
  acts_as_list :scope => :publication
  belongs_to :country_team
  belongs_to :focus_group
end
