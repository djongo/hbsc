class AddMediatorsToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :mediators, :string
  end

  def self.down
    remove_column :versions, :mediators
  end
end
