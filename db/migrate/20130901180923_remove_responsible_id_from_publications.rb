class RemoveResponsibleIdFromPublications < ActiveRecord::Migration
  def self.up
    remove_column :publications, :responsible_id
  end

  def self.down
    add_column :publications, :responsible_id, :integer
  end
end
