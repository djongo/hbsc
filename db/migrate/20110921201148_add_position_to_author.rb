class AddPositionToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :position, :integer
  end

  def self.down
    remove_column :authors, :position
  end
end
