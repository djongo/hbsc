class User < ActiveRecord::Base
attr_accessible :full_name
   # attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :roles_mask, :with_role, :roles; :role_symbol, :deliver_password_reset_instructions, :full
  acts_as_authentic
  has_many :publications
  has_many :authorships
  has_many :publications, :through => :authorships
  has_many :notes

  named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }


  # new roles MUST be added to the end of the array since it is a bit mask
  ROLES = %w[publication_group author]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  
  def role_symbols
    roles.map(&:to_sym)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def full_name
    [first_name, last_name].join(' ')
  end  

  def full_name=(name)
    split = name.split(' ', 2)
    self.first_name = split.first
    self.last_name = split.last
  end
end
