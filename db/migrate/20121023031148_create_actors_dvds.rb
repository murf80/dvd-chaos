class CreateActorsDvds < ActiveRecord::Migration
  def self.up
    create_table :actors_dvds, :id => false do |t|
      t.references :actor
      t.references :dvd
    end
    add_index :actors_dvds, [:actor_id, :dvd_id]
    add_index :actors_dvds, [:dvd_id, :actor_id]
  end

  def self.down
    drop_table :actors_dvds
  end
end
