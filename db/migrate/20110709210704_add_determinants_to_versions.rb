class AddDeterminantsToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :determinants, :string
  end

  def self.down
    remove_column :versions, :determinants
  end
end
