class User < ActiveRecord::Base
  attr_accessible :name, :email, :login, :password
end
