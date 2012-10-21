class CreateDvds < ActiveRecord::Migration
  def change
    create_table :dvds do |t|
      t.string, :na;me
      t.datetime, :release_date
      t.string, :summary
      t.string= :asin

      t.timestamps

      add_index :dvds, :name, :unique => true
    end
  end
end
