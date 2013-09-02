class RemovePromotionFromPublications < ActiveRecord::Migration
  def self.up
    remove_column :publications, :promotion
  end

  def self.down
    add_column :publications, :promotion, :boolean
  end
end
