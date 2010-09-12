class AddStateToPublications < ActiveRecord::Migration
  def self.up
    add_column :publications, :state, :string
    add_column :publications, :access_state, :string
  end

  def self.down
    remove_column :publications, :access_state
    remove_column :publications, :state
  end
end
