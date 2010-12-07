class ChangeReferenceInPublications < ActiveRecord::Migration
  def self.up
    change_column :publications, :reference, :text
  end

  def self.down
    change_column :publications, :reference, :string    
  end
end
