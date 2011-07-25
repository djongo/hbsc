class AddFoundationsToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :foundations, :string
  end

  def self.down
    remove_column :versions, :foundations
  end
end
