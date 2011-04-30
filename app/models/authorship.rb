class Authorship < ActiveRecord::Base
  belongs_to :publication
  belongs_to :user

  def user_name
    user.full_name if user
  end
  
end
