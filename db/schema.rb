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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160326090328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.integer  "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "battles", ["status"], name: "index_battles_on_status", using: :btree

  create_table "participations", force: :cascade do |t|
    t.integer  "status",                    null: false
    t.integer  "winners_count", default: 0, null: false
    t.integer  "user_id",                   null: false
    t.integer  "battle_id",                 null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "participations", ["battle_id"], name: "index_participations_on_battle_id", using: :btree
  add_index "participations", ["user_id"], name: "index_participations_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "file"
    t.integer  "status",                   null: false
    t.float    "rating",     default: 0.0, null: false
    t.integer  "user_id",                  null: false
    t.integer  "round_id",                 null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "photos", ["round_id"], name: "index_photos_on_round_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.integer  "number",     null: false
    t.integer  "status",     null: false
    t.integer  "battle_id",  null: false
    t.integer  "target_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rounds", ["battle_id"], name: "index_rounds_on_battle_id", using: :btree
  add_index "rounds", ["target_id"], name: "index_rounds_on_target_id", using: :btree

  create_table "targets", force: :cascade do |t|
    t.text     "desc",       null: false
    t.json     "criterion",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
