class AddStateToPublication < ActiveRecord::Migration
  def self.up
    change_column :publications, :state, :string, :default => "preplanned"
  end

  def self.down
    remove_column :publications, :state
  end
end
