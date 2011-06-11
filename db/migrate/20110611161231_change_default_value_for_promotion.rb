class ChangeDefaultValueForPromotion < ActiveRecord::Migration
  def self.up
    change_column :publications, :promotion, :boolean, :default => true
  end

  def self.down
    change_column :publications, :promotion, :boolean, :default => false
  end
end
