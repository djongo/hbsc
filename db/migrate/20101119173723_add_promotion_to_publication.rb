class AddPromotionToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :promotion, :boolean, :default => false
  end

  def self.down
    remove_column :publications, :promotion
  end
end
