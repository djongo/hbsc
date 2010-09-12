class CreateDeterminants < ActiveRecord::Migration
  def self.up
    create_table :determinants do |t|
      t.integer :publication_id
      t.integer :variable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :determinants
  end
end
