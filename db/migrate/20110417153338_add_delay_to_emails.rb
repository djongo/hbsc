class AddDelayToEmails < ActiveRecord::Migration
  def self.up
    add_column :emails, :delay, :integer, :default => 0
  end

  def self.down
    remove_column :emails, :delay
  end
end
