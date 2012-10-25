class DirectorRemoveDvdId < ActiveRecord::Migration
  def up
    remove_index :directors, :dvd_id
    remove_column :directors, :dvd_id
  end

  def down
    add_column :directors, :dvd_id, :integer
    add_index :directors, :dvd_id
  end
end
