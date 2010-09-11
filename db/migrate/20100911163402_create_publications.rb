class CreatePublications < ActiveRecord::Migration
  def self.up
    create_table :publications do |t|
      t.string :title
      t.text :description
      t.integer :language_id
      t.integer :publication_type_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :publications
  end
end
