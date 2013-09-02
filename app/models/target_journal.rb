class TargetJournal < ActiveRecord::Base
#  attr_accessible :name
 has_many :publications
  
  def target_journal_name
    target_journal.name if target_journal
  end

  def target_journal_name=(name)
    self.target_journal = TargetJournal.find_or_create_by_name(name) unless name.blank?
  end
#  def variable_name
#    variable.name if variable
#  end

#  def variable_name=(name)
#    self.variable = Variable.find_or_create_by_name(name) unless name.blank?
#  end    
end
