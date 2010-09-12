class CreatePopulations < ActiveRecord::Migration
  def self.up
    create_table :populations do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :populations
  end
end
