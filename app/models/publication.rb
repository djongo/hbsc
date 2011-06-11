class Publication < ActiveRecord::Base
#  attr_accessible :title, :description, :language_id, :publication_type_id
  include AASM
  has_paper_trail
  acts_as_indexed :fields => [
    :title, :description,
    :variable_list, :survey_list, :language_list, :email_list, :username_list,
    :population_list, :publication_type_list, :state
#    :focus_group_list, :country_team_list
    ]

  belongs_to :language
  belongs_to :publication_type
  belongs_to :user
  belongs_to :responsible, :class_name => "User"
  belongs_to :contact, :class_name => "User"
  belongs_to :target_journal
  
  has_many :notes, :dependent => :destroy
  accepts_nested_attributes_for :notes, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  has_many :reminders, :dependent => :destroy
 
  has_many :authorships
  has_many :users, :through => :authorships
  
  has_many :keywords
  has_many :variables, :through => :keywords

  has_many :determinants
  has_many :variables, :through => :determinants
  has_many :mediators
  has_many :variables, :through => :mediators
  has_many :outcomes
  has_many :variables, :through => :outcomes
  has_many :foundations
  has_many :surveys, :through => :foundations
  has_many :inclusions
  has_many :populations, :through => :inclusions

  # Approach to get fully custom error message
  HUMANIZED_ATTRIBUTES = { 
      :title => "Working title",
      :contact_id => "Contact person",
      :responsible_id => "Responsible pi"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  validates_presence_of :title, :language_id, :publication_type, :user_id
  validates_presence_of :responsible_id, :contact_id
  validates_inclusion_of :promotion, :in => [true,false]
  validates_associated :variables
  validates_associated :surveys
  validates_associated :populations
  validates_associated :target_journal
#  validates_associated :users

  accepts_nested_attributes_for :target_journal,
                                :allow_destroy => false,
                                :reject_if => proc { |attrs|
                                attrs['target_journal_name'].blank? }
  
  accepts_nested_attributes_for :keywords,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['variable_name'].blank? }
  accepts_nested_attributes_for :determinants,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['variable_name'].blank? }
  accepts_nested_attributes_for :mediators,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['variable_name'].blank? }
  accepts_nested_attributes_for :outcomes,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['variable_name'].blank? } 
  accepts_nested_attributes_for :foundations,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['survey_name'].blank? &&
                                  attrs['survey_id'].blank? }
  accepts_nested_attributes_for :inclusions,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['population_name'].blank? &&
                                  attrs['population_id'].blank? }
  accepts_nested_attributes_for :authorships,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['full_name'].blank? &&
                                  attrs['user_id'].blank? }

  def validate
    # require a minimum of one keyword, population, determinant, outcome
    # measure, confounder/mediator, survey_data
    undestroyed_keyword_count = 0
    undestroyed_foundation_count = 0
    undestroyed_inclusion_count = 0
    undestroyed_determinant_count = 0
    undestroyed_mediator_count = 0
    undestroyed_outcome_count = 0
                      
    keywords.each { |t| undestroyed_keyword_count += 1 unless t.marked_for_destruction? }
    errors.add_to_base 'There must be at least one keyword' if undestroyed_keyword_count < 1
    
    foundations.each { |u| undestroyed_foundation_count +=1 unless u.marked_for_destruction? }
    errors.add_to_base 'There must be at least one set of survey data' if undestroyed_foundation_count < 1
    
    inclusions.each { |v| undestroyed_inclusion_count +=1 unless v.marked_for_destruction? }
    errors.add_to_base 'There must be at least one population' if undestroyed_inclusion_count < 1    

    outcomes.each { |w| undestroyed_outcome_count +=1 unless w.marked_for_destruction? }
    errors.add_to_base 'There must be at least one outcome measure' if undestroyed_outcome_count < 1  

    determinants.each { |x| undestroyed_determinant_count +=1 unless x.marked_for_destruction? }
    errors.add_to_base 'There must be at least one determinant' if undestroyed_determinant_count < 1  

    mediators.each { |y| undestroyed_mediator_count +=1 unless y.marked_for_destruction? }
    errors.add_to_base 'There must be at least one confounder or mediator' if undestroyed_mediator_count < 1  
  end
#  accepts_nested_attributes_for :users
    
  # functions for acts_as_indexed to enable 
  # multi model search

  def variable_list
    variables.map(&:name).join(' ')
  end

  def survey_list
    surveys.map(&:name).join(' ').to_s
  end

  def language_list
    language.name
  end

  def email_list
    users.map(&:email).join(' ')
  end

  def username_list
    users.map(&:full_name).join(' ')
  end

  def population_list
    populations.map(&:name).join(' ')
  end

  def publication_type_list
    publication_type.name
  end

  # defining the workflow

  aasm_column :state
  aasm_initial_state :preplanned
  aasm_state :preplanned
  aasm_state :preplanned_submitted
  aasm_state :planned
  aasm_state :planned_submitted
  aasm_state :inprogress
  aasm_state :inprogress_submitted
  aasm_state :submitted
  aasm_state :submitted_submitted
  aasm_state :accepted
  aasm_state :accepted_submitted
  aasm_state :published

  # Preplanned to planned  
  aasm_event :preplanned_submit do
    transitions :to => :preplanned_submitted, :from => [:preplanned]
  end
  
  aasm_event :preplanned_reject do
    transitions :to => :preplanned, :from => [:preplanned_submitted]
  end

  aasm_event :preplanned_accept do
    transitions :to => :planned, :from => [:preplanned_submitted]
  end

  aasm_event :preplanned_remind do
    transitions :to => :preplanned, :from => [:preplanned]
  end

  # Planned to Inprogress
  aasm_event :planned_submit do
    transitions :to => :planned_submitted, :from => [:planned]
  end
  
  aasm_event :planned_reject do
    transitions :to => :planned, :from => [:planned_submitted]
  end

  aasm_event :planned_accept do
    transitions :to => :inprogress, :from => [:planned_submitted]
  end
  
  aasm_event :planned_remind do
    transitions :to => :planned, :from => [:planned]
  end
    
  # Inprogress to Submitted
  aasm_event :inprogress_submit do
    transitions :to => :inprogress_submitted, :from => [:inprogress]
  end
  
  aasm_event :inprogress_reject do
    transitions :to => :inprogress, :from => [:inprogress_submitted]
  end

  aasm_event :inprogress_accept do
    transitions :to => :submitted, :from => [:inprogress_submitted]
  end
  
  aasm_event :inprogess_remind do
    transitions :to => :inprogress, :from => [:inprogess]
  end
  
  # Submitted to Accepted
  aasm_event :submitted_submit do
    transitions :to => :submitted_submitted, :from => [:submitted]
  end
  
  aasm_event :submitted_reject do
    transitions :to => :submitted, :from => [:submitted_submitted]
  end

  aasm_event :submitted_accept do
    transitions :to => :accepted, :from => [:submitted_submitted]
  end
  
  aasm_event :submitted_remind do
    transitions :to => :submitted, :from => [:submitted]
  end
  
  # Accepted to Published
  aasm_event :accepted_submit do
    transitions :to => :accepted_submitted, :from => [:accepted]
  end
  
  aasm_event :accepted_reject do
    transitions :to => :accepted, :from => [:accepted_submitted]
  end

  aasm_event :accepted_accept do
    transitions :to => :published, :from => [:accepted_submitted]
  end
  
  aasm_event :accepted_remind do
    transitions :to => :accepted, :from => [:accepted]
  end

  # the functions      
  def send_preplanned_accept
    flash[:notice] = "Accepted as planned"
  end
  
  def send_preplanned_reject
    flash[:error] = "Rejected"
  end

  def send_planned_accept
    flash[:notice] = "Accepted as inprogress"
  end
  
  def send_planned_reject
    flash[:error] = "Rejected"
  end

  def send_inprogress_accept
    flash[:notice] = "Accepted as submitted"
  end
  
  def send_inprogress_reject
    flash[:error] = "Rejected"
  end

  def send_submitted_accept
    flash[:notice] = "Accepted as accepted"
  end
  
  def send_submitted_reject
    flash[:error] = "Rejected"
  end

  def send_accepted_accept
    flash[:notice] = "Accepted as published"
  end
  
  def send_accepted_reject
    flash[:error] = "Rejected"
  end

end
