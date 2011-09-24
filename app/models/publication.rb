class Publication < ActiveRecord::Base
#  attr_accessible :title, :description, :language_id, :publication_type_id
  include AASM
  has_paper_trail   :meta => { 
    :keywords => Proc.new { |publication|  publication.hmt_list(publication.keywords) },
    :mediators => Proc.new { |publication|  publication.hmt_list(publication.mediators) }, 
    :outcomes => Proc.new { |publication|  publication.hmt_list(publication.outcomes) },    
    :determinants => Proc.new { |publication|  publication.hmt_list(publication.determinants) },   
    :inclusions => Proc.new { |publication|  publication.inclusions_list },    
    :foundations => Proc.new { |publication|  publication.foundations_list }            
    }
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
  has_many :authors, :order => "position", :dependent => :destroy
 
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
                                  
  accepts_nested_attributes_for :authors,
                                :allow_destroy => true,
                                :reject_if => proc { |attrs|
                                attrs['name'].blank? &&
                                  attrs['user_id'].blank? }                                  

#  serialize :author_information, Hash

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
  
  # methods for export
  def keywords_xls
    self.keywords.map(&:variable_name).join(', ')
  end
  
  def outcomes_xls
    self.outcomes.map(&:variable_name).join(', ')    
  end

  def determinants_xls
    self.determinants.map(&:variable_name).join(', ')    
  end

  def mediators_xls
    self.mediators.map(&:variable_name).join(', ')    
  end

  def surveys_xls
    self.surveys.map(&:name).join(', ')
  end
  
  def populations_xls
    self.populations.map(&:name).join(', ')
  end
  
  # methods for meta data for versions
  def hmt_list(hmt)
    l = []
    hmt.each do |k|
#      puts "just before adding to array: #{k}"
      l << k.variable_id unless k.marked_for_destruction?
    end
    return l.sort.to_yaml
  end

#  def keyword_list
#    l = []
#    self.keywords.each do |k|
#      l << k.variable_id
#    end
#    return l.sort.to_yaml
#  end  
  
  # given a yaml list of variable ids return names as concatenated string
  def list_variable_names(yaml_list)
    l = ""
    if !yaml_list.nil?
      YAML.load(yaml_list).each do |k|
        l += Variable.find_by_id(k).name + " "
      end
    end
    return l.chomp(" ")
  end

  def inclusions_list
    l = []
    self.inclusions.each do |k|
      l << k.population_id unless k.marked_for_destruction?
    end
    return l.sort.to_yaml
  end

  def list_inclusion_names(yaml_list)
    l = ""
    if !yaml_list.nil?
      YAML.load(yaml_list).each do |k|
        l += Population.find_by_id(k).name + " "
      end
    end
    return l.chomp(" ")
  end

  def foundations_list
    l = []
    self.foundations.each do |k|
      l << k.survey_id unless k.marked_for_destruction?
    end
    return l.sort.to_yaml
  end

  def list_foundation_names(yaml_list)
    l = ""
    if !yaml_list.nil?
      YAML.load(yaml_list).each do |k|
        l += Survey.find_by_id(k).name + " "
      end
    end
    return l.chomp(" ")
  end

  # compare with previous version and output differences
  def compare
    # creating array for version changes
    version_change_array = []
    puts "COMPARING..."
#    self.versions.first
    self.versions.reverse.each do |v|
      if v.index >= 1
      puts "IN LOOP " + v.index.to_s

    # current version of publication does not exist in the 
    # version table so creating hash manually
        if v.next.nil?
          puts "first runthrough"
          ch = {}
          ch_keys = %w[title description language_id publication_type_id user_id state reference promotion archived url]
          ch_keys.each do |key|
            ch["#{key}"] = self.send("#{key}".to_sym).to_s
          end

          ch["event"] = "update"
          ch["whodunnit"] = v.terminator.to_s
          ch["index"] = "current"
          ch["keyword_list"] = self.hmt_list(self.keywords)
          ch["outcome_list"] = self.hmt_list(self.outcomes)
          ch["determinant_list"] = self.hmt_list(self.determinants)          
          ch["mediator_list"] = self.hmt_list(self.mediators)
          ch["inclusion_list"] = self.inclusions_list
          ch["foundation_list"] = self.foundations_list
          puts "assigned self as current"

          previous_version = v.object
#          ph = YAML.load(previous_version)
          ph = Hash[ *previous_version.split("\n").collect { |e| [e.split(":")[0],e.split(":")[1]] }.flatten ]
          ph["event"] = v.previous.event
          ph["whodunnit"] = v.previous.whodunnit
          ph["index"] = v.previous.index.to_s
          ph["keyword_list"] = v.previous.keywords
          ph["outcome_list"] = v.previous.outcomes
          ph["determinant_list"] = v.previous.determinants     
          ph["mediator_list"] = v.previous.mediators
          ph["inclusion_list"] = v.previous.inclusions
          ph["foundation_list"] = v.previous.foundations
          puts "assigned first version as previous"   
      
        else
          puts "progressing normally"
          # convert version objects to hash with field => value
          current_version = v.next.object
#          ch = YAML.load(current_version)
          ch = Hash[ *current_version.split("\n").collect { |e| [e.split(":")[0],e.split(":")[1]] }.flatten ]
          ch["event"] = v.event
          ch["whodunnit"] = v.whodunnit
          ch["index"] = v.index.to_s
          ch["keyword_list"] = v.keywords
          ch["outcome_list"] = v.outcomes
          ch["determinant_list"] = v.determinants     
          ch["mediator_list"] = v.mediators     
          ch["inclusion_list"] = v.inclusions
          ch["foundation_list"] = v.foundations     
    puts "assigned current"

          previous_version = v.object
#          ph = YAML.load(previous_version)
          ph = Hash[ *previous_version.split("\n").collect { |e| [e.split(":")[0],e.split(":")[1]] }.flatten ]
          ph["event"] = v.previous.event
          ph["whodunnit"] = v.previous.whodunnit
          ph["index"] = v.previous.index.to_s
          ph["keyword_list"] = v.previous.keywords
          ph["outcome_list"] = v.previous.outcomes
          ph["determinant_list"] = v.previous.determinants     
          ph["mediator_list"] = v.previous.mediators      
          ph["inclusion_list"] = v.previous.inclusions
          ph["foundation_list"] = v.previous.foundations
      puts "assigned previous"
        end  
        # create hash of diffs
        puts "figuring out diffs"
        dh = {}
        
        ch["keywords"] = list_variable_names(ch["keyword_list"])
        ph["keywords"] = list_variable_names(ph["keyword_list"])
        
        ch["outcomes"] = list_variable_names(ch["outcome_list"])
        ph["outcomes"] = list_variable_names(ph["outcome_list"])           

        ch["determinants"] = list_variable_names(ch["determinant_list"])
        ph["determinants"] = list_variable_names(ph["determinant_list"])  
        
        ch["mediators"] = list_variable_names(ch["mediator_list"])
        ph["mediators"] = list_variable_names(ph["mediator_list"])
        
        ch["inclusions"] = list_inclusion_names(ch["inclusion_list"])
        ph["inclusions"] = list_inclusion_names(ph["inclusion_list"])

        ch["foundations"] = list_foundation_names(ch["foundation_list"])
        ph["foundations"] = list_foundation_names(ph["foundation_list"])

        
        # checking string keys
        str_keys = %w[title description state reference promotion archived url index keywords outcomes determinants mediators inclusions foundations]
        str_keys.each do |key|
          ch[key].nil? ? c = " " : c = ch[key].lstrip
          ph[key].nil? ? p = " " : p = ph[key].lstrip          
          dh[key] = Differ.diff(c,p)
        end
        
        #checking id keys
        id_keys = %w[language_id publication_type_id user_id]
        id_keys.each do |idk|
          ch[idk].nil? ? c = " " : c = idk.gsub('_id','').gsub('_',' ').titleize.gsub(' ','').constantize.first(:conditions => ["id=?",ch[idk].lstrip]).name
          ph[idk].nil? ? p = " " : p = idk.gsub('_id','').gsub('_',' ').titleize.gsub(' ','').constantize.first(:conditions => ["id=?",ph[idk].lstrip]).name
          dh[idk] = Differ.diff(c,p)
        end

        dh["event"] = ch["event"].lstrip
        dh["whodunnit"] = User.first(:conditions => ["id=?",ch["whodunnit"].lstrip]).full_name

        version_change_array << dh
#        puts "diff added to versions array"
      end
    end
    version_change_array
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
