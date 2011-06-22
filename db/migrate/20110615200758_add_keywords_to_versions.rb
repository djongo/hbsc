class AddKeywordsToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :keywords, :string
  end

  def self.down
    remove_column :versions, :keywords
  end
end
