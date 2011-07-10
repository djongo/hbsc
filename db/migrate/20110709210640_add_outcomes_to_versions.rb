class AddOutcomesToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :outcomes, :string
  end

  def self.down
    remove_column :versions, :outcomes
  end
end
