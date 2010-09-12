class Publication < ActiveRecord::Base
#  attr_accessible :title, :description, :language_id, :publication_type_id

  acts_as_indexed :fields => [
    :title, :description,
    :variable_list, :survey_list, :language_list, :email_list, :username_list,
    :population_list, :publication_type_list,
#    :focus_group_list, :country_team_list
    ]

  belongs_to :language
  belongs_to :publication_type
  belongs_to :user
  
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

  validates_presence_of :title
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


end
