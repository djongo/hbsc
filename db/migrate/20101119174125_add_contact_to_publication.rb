class AddContactToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :contact_id, :integer
  end

  def self.down
    remove_column :publications, :contact_id
  end
end
