class ChangeColumnTitleInPublications < ActiveRecord::Migration
  def self.up
    change_column :publications, :title, :text
  end

  def self.down
    change_column :publications, :title, :string    
  end
end
