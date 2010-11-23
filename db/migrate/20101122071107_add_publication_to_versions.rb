class AddPublicationToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :publication_id, :integer
  end

  def self.down
    remove_column :versions, :publication_id
  end
end
