class AddHbscMemberToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :hbsc_member, :boolean, :default => false
  end

  def self.down
    remove_column :users, :hbsc_member
  end
end
