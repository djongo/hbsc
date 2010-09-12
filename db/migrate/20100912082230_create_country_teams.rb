class CreateCountryTeams < ActiveRecord::Migration
  def self.up
    create_table :country_teams do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :country_teams
  end
end
