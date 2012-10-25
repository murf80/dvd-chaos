class DirectorDobToDatetime < ActiveRecord::Migration
  def up
    change_column :directors, :dob, :datetime
  end

  def down
    change_column :directors, :dob, :string
  end
end
