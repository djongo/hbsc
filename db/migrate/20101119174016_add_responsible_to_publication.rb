class AddResponsibleToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :responsible_id, :integer
  end

  def self.down
    remove_column :publications, :responsible_id
  end
end
