class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.integer :publication_id
      t.string :name
      t.string :email
      t.integer :country_team_id
      t.integer :focus_group_id
      t.boolean :first_author, :default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :authors
  end
end
