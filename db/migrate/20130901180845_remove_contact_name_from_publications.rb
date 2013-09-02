class RemoveContactNameFromPublications < ActiveRecord::Migration
  def self.up
    remove_column :publications, :contact_name
  end

  def self.down
    add_column :publications, :contact_name, :string
  end
end
