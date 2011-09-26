class AddContactInformationToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :contact_name, :string
    add_column :publications, :contact_email, :string
  end

  def self.down
    remove_column :publications, :contact_email
    remove_column :publications, :contact_name
  end
end
