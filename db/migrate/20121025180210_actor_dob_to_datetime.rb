class ActorDobToDatetime < ActiveRecord::Migration
  def up
    change_column :actors, :dob, :datetime
  end

  def down
    change_column :actors, :dob, :string
  end
end
