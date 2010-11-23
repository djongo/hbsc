class CreateTargetJournals < ActiveRecord::Migration
  def self.up
    create_table :target_journals do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :target_journals
  end
end
