class Mediator < ActiveRecord::Base
  belongs_to :publication
  belongs_to :variable

  def variable_name
    variable.name if variable
  end

  def variable_name=(name)
    self.variable = Variable.find_or_create_by_name(name) unless name.blank?
  end

end
