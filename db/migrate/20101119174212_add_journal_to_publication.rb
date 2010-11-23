class AddJournalToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :target_journal_id, :integer
  end

  def self.down
    remove_column :publications, :target_journal_id
  end
end
