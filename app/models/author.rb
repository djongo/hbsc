class Author < ActiveRecord::Base
 attr_accessible :publication_id, :name, :email, :country_team_id, 
    :focus_group_id, :position, :country_team_name, :focus_group_name
  belongs_to :publication
  acts_as_list :scope => :publication
  belongs_to :country_team
  belongs_to :focus_group

  def country_team_name
    country_team.name if country_team
  end

  def focus_group_name
    focus_group.name if focus_group
  end
end
