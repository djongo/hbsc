class AddInclusionsToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :inclusions, :string
  end

  def self.down
    remove_column :versions, :inclusions
  end
end
