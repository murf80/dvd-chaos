class DirectorAddDvdId < ActiveRecord::Migration
  def up
    add_column :directors, :dvd_id, :integer
    add_index :directors, :dvd_id
  end

  def down
    remove_column :directors, :dvd_id
    remove_index :directors, :dvd_id
  end
end
