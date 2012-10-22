# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121022031601) do

  create_table "actors", :force => true do |t|
    t.string   "name"
    t.string   "dob"
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "actors", ["name"], :name => "index_actors_on_name", :unique => true

  create_table "directors", :force => true do |t|
    t.string   "name"
    t.string   "dob"
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "directors", ["name"], :name => "index_directors_on_name", :unique => true

  create_table "dvds", :force => true do |t|
    t.string   "name"
    t.datetime "release_date"
    t.string   "summary"
    t.string   "asin"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "dvds", ["name"], :name => "index_dvds_on_name", :unique => true

end
