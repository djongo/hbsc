class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :email,              :default => "", :null => false
      t.string    :first_name
      t.string    :last_name
      t.string    :crypted_password
      t.string    :password_salt
      t.string    :persistence_token
      t.integer   :login_count,        :default => 0,  :null => false
      t.integer   :failed_login_count, :default => 0,  :null => false      
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :last_login_ip
      t.string    :perishable_token,   :default => "", :null => false      
      t.timestamps
    end

    add_index "users", ["email"], :name => "index_users_on_email"
    add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"    

  end
  
  def self.down
    drop_table :users
  end
end
