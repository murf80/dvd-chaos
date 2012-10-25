class DvdReleaseDateToString < ActiveRecord::Migration
  def up
    change_column :dvds, :release_date, :string
  end

  def down
    change_column :dvds, :release_date, :datetime
  end
end
