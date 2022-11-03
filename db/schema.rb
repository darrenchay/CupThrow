# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_03_041444) do

  create_table "containers", force: :cascade do |t|
    t.string "type"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_containers_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "bag_id", null: false
    t.integer "player_cup_id", null: false
    t.integer "server_cup_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "type"
    t.string "colour"
    t.integer "sides"
    t.float "denomination"
    t.integer "container_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["container_id"], name: "index_items_on_container_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "points", default: 0
    t.integer "bag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "containers", "users"
  add_foreign_key "games", "containers", column: "bag_id"
  add_foreign_key "games", "containers", column: "player_cup_id"
  add_foreign_key "games", "containers", column: "server_cup_id"
  add_foreign_key "games", "users"
end
