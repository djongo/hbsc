class RemoveAuthorInformationFromPublications < ActiveRecord::Migration
  def self.up
    remove_column :publications, :author_information    
  end

  def self.down
    add_column :publications, :author_information, :string  
  end
end
