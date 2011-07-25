class Keyword < ActiveRecord::Base
  belongs_to :publication
  belongs_to :variable
#  has_paper_trail   :meta => { :publication_id => Proc.new { |keyword|
#                                keyword.publication_id } 
#                              }

  def variable_name
    variable.name if variable
  end

  def variable_name=(name)
    self.variable = Variable.find_or_create_by_name(name) unless name.blank?
  end
  
end    
