class DropAuthorships < ActiveRecord::Migration
  def self.up
    drop_table :authorships    
  end

  def self.down
    create_table :authorships do |t|
      t.integer :publication_id
      t.integer :user_id

      t.timestamps
    end    
  end
end
