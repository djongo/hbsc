class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.integer :publication_id
      t.string :state
      t.string :action
      t.timestamp :last_email_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :reminders
  end
end
