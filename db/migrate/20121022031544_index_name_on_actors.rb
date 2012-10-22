class IndexNameOnActors < ActiveRecord::Migration
  def up
    add_index :actors, :name, :unique => true
  end

  def down
    remove_index :actors, :name, :unique => true
  end
end
