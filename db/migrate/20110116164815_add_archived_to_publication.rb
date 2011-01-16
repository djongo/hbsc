class AddArchivedToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :archived, :boolean, :default => false
  end

  def self.down
    remove_column :publications, :archived
  end
end
