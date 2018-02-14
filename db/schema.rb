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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180214164453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aircrafts", force: :cascade do |t|
    t.string "name"
    t.string "drone_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missions", force: :cascade do |t|
    t.bigint "aircraft_id"
    t.string "name"
    t.time "starttime"
    t.time "endtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_missions_on_aircraft_id"
  end

  create_table "parts", force: :cascade do |t|
    t.bigint "aircraft_id"
    t.string "name"
    t.string "description"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_parts_on_aircraft_id"
    t.index ["status_id"], name: "index_parts_on_status_id"
  end

  create_table "route_gps", force: :cascade do |t|
    t.bigint "mission_id"
    t.time "time"
    t.float "lat"
    t.float "lon"
    t.float "alt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id"], name: "index_route_gps_on_mission_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "missions", "aircrafts"
  add_foreign_key "parts", "aircrafts"
  add_foreign_key "parts", "statuses"
  add_foreign_key "route_gps", "missions"
end
