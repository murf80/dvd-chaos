class DvdReleaseDateToDatetime < ActiveRecord::Migration
  def up
    change_column :dvds, :release_date, :datetime
  end

  def down
    change_column :dvds, :release_date, :string
  end
end
