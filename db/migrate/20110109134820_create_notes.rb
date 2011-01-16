class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :publication_id
      t.integer :user_id
      t.string :state
      t.timestamps
    end
  end
  
  def self.down
    drop_table :notes
  end
end
