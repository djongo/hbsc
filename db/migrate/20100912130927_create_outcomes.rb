class CreateOutcomes < ActiveRecord::Migration
  def self.up
    create_table :outcomes do |t|
      t.integer :publication_id
      t.integer :variable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :outcomes
  end
end
