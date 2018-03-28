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

ActiveRecord::Schema.define(version: 20180327023945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rooms", force: :cascade do |t|
    t.string "key"
    t.boolean "online"
    t.string "redis"
    t.string "channel"
    t.string "stream_ip"
    t.string "creater_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel"], name: "index_rooms_on_channel"
    t.index ["creater_ip"], name: "index_rooms_on_creater_ip"
    t.index ["key"], name: "index_rooms_on_key"
    t.index ["online"], name: "index_rooms_on_online"
    t.index ["stream_ip"], name: "index_rooms_on_stream_ip"
  end

end
