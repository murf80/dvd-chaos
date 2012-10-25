class DvdAddDirectorId < ActiveRecord::Migration
  def up
    add_column :dvds, :director_id, :integer
    add_index :dvds, :director_id
  end

  def down
    remove_column :dvds, :director_id
    remove_index :dvds, :director_id
  end
end
