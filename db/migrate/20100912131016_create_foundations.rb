class CreateFoundations < ActiveRecord::Migration
  def self.up
    create_table :foundations do |t|
      t.integer :publication_id
      t.integer :survey_id

      t.timestamps
    end
  end

  def self.down
    drop_table :foundations
  end
end
