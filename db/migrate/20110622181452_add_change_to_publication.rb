class AddChangeToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :change, :string
  end

  def self.down
    remove_column :publications, :change
  end
end
