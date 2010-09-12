class CreateFocusGroups < ActiveRecord::Migration
  def self.up
    create_table :focus_groups do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :focus_groups
  end
end
