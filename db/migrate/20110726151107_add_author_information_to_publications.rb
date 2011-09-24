class AddAuthorInformationToPublications < ActiveRecord::Migration
  def self.up
    add_column :publications, :author_information, :string
  end

  def self.down
    remove_column :publications, :author_information
  end
end
