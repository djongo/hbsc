class AddContentToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :content, :text
  end

  def self.down
    remove_column :notes, :content
  end
end
