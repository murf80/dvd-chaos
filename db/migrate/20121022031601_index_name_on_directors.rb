class IndexNameOnDirectors < ActiveRecord::Migration
  def up
    add_index :directors, :name, :unique => true
  end

  def down
    remove_index :directors, :name, :unique => true
  end
end
