class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string, :[name
      t.string, :dob
      t.string] :gender

      t.timestamps

      add_index :staffs, :name, :unique => true
    end
  end
end
