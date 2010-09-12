class CreateInclusions < ActiveRecord::Migration
  def self.up
    create_table :inclusions do |t|
      t.integer :publication_id
      t.integer :population_id

      t.timestamps
    end
  end

  def self.down
    drop_table :inclusions
  end
end
