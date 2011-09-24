class RemoveFirstAuthorFromAuthor < ActiveRecord::Migration
  def self.up
    remove_column :authors, :first_author
  end

  def self.down
    add_column :authors, :first_author, :boolean, :default => false
  end
end
