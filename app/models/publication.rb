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

  validates_presence_of :title, :language_id, :publication_type, :user_id
  validates_presence_of :responsible_id, :contact_id, :target_journal
  validates_associated :variables
  validates_associated :surveys
  validates_associated :populations
#  validates_associated :users
  
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
  aasm_state :preplanned_rejected
  aasm_state :planned
  aasm_state :planned_submitted
  aasm_state :planned_rejected
  aasm_state :inprogress
  aasm_state :inprogress_submitted
  aasm_state :inprogress_rejected
  aasm_state :submitted
  aasm_state :submitted_submitted
  aasm_state :submitted_rejected
  aasm_state :accepted
  aasm_state :accepted_submitted
  aasm_state :accepted_rejected
  aasm_state :published

  # Preplanned to planned  
  aasm_event :preplanned_submit do
    transitions :to => :preplanned_submitted, :from => [:preplanned]
  end
  
  aasm_event :preplanned_reject do
    transitions :to => :preplanned_rejected, :from => [:preplanned_submitted]
  end

  aasm_event :planned do
    transitions :to => :planned, :from => [:preplanned_submitted]
  end

  # Planned to Inprogress
  aasm_event :planned_submit do
    transitions :to => :planned_submitted, :from => [:planned]
  end
  
  aasm_event :planned_reject do
    transitions :to => :planned_rejected, :from => [:planned_submitted]
  end

  aasm_event :inprogress do
    transitions :to => :inprogress, :from => [:planned_submitted]
  end
  
  # Inprogress to Submitted
  aasm_event :inprogress_submit do
    transitions :to => :inprogress_submitted, :from => [:inprogress]
  end
  
  aasm_event :inprogress_reject do
    transitions :to => :inprogress_rejected, :from => [:inprogress_submitted]
  end

  aasm_event :submitted do
    transitions :to => :submitted, :from => [:inprogress_submitted]
  end

  # Submitted to Accepted
  aasm_event :submitted_submit do
    transitions :to => :submitted_submitted, :from => [:submitted]
  end
  
  aasm_event :submitted_reject do
    transitions :to => :submitted_rejected, :from => [:submitted_submitted]
  end

  aasm_event :accepted do
    transitions :to => :accepted, :from => [:submitted_submitted]
  end
  
  # Accepted to Published
  aasm_event :accepted_submit do
    transitions :to => :accepted_submitted, :from => [:accepted]
  end
  
  aasm_event :accepted_reject do
    transitions :to => :accepted_rejected, :from => [:accepted_submitted]
  end

  aasm_event :published do
    transitions :to => :published, :from => [:accepted_submitted]
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
