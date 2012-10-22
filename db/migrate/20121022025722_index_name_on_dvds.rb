class IndexNameOnDvds < ActiveRecord::Migration
  def up
    add_index :dvds, :name, :unique => true
  end

  def down
    remove_index :dvds, :name, :unique => true
  end
end
