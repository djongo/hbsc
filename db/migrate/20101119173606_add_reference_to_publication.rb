class AddReferenceToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :reference, :string
  end

  def self.down
    remove_column :publications, :reference
  end
end
