class RemoveContactEmailFromPublications < ActiveRecord::Migration
  def self.up
    remove_column :publications, :contact_email
  end

  def self.down
    add_column :publications, :contact_email, :string
  end
end
