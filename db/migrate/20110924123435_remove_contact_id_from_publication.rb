class RemoveContactIdFromPublication < ActiveRecord::Migration
  def self.up
    remove_column :publications, :contact_id
  end

  def self.down
    add_column :publications, :contact_id, :integer    
  end
end
