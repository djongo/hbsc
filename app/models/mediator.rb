class Mediator < ActiveRecord::Base
  belongs_to :publication
  belongs_to :variable

  def variable_name
    variable.name if variable
  end

  def variable_name=(name)
    self.variable = Variable.find_or_create_by_name(name) unless name.blank?
  end

#Parent.class_eval do 
#  def one_mediator
#    errors.add_to_base "wrong" if @mediators.target.size < 1
#  end
#end
#  def validate
#    undestroyed_mediator_count = 0
#    self.each { |y| undestroyed_mediator_count +=1 unless y.marked_for_destruction? }
#    errors.add_to_base 'There must be at least one confounder or mediator' if undestroyed_mediator_count < 1  
#  end
end
