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

ActiveRecord::Schema.define(version: 2021_10_13_114459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmakers", force: :cascade do |t|
    t.string "name_en", limit: 10, null: false
    t.string "name_ru", limit: 10, null: false
    t.string "slug", limit: 10, null: false
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_bookmakers_on_slug"
  end

  create_table "events", force: :cascade do |t|
    t.string "external_id"
    t.bigint "parent_id", default: 1, null: false
    t.bigint "bookmaker_id", null: false
    t.bigint "league_id", null: false
    t.bigint "sport_id", null: false
    t.integer "level", default: 1, null: false
    t.bigint "team1_id", null: false
    t.bigint "team2_id", null: false
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookmaker_id"], name: "index_events_on_bookmaker_id"
    t.index ["external_id"], name: "index_events_on_external_id"
    t.index ["league_id"], name: "index_events_on_league_id"
    t.index ["slug"], name: "index_events_on_slug"
    t.index ["sport_id"], name: "index_events_on_sport_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name_en", limit: 15, null: false
    t.string "name_ru", limit: 15, null: false
    t.integer "sex", limit: 2
    t.string "slug", limit: 15, null: false
    t.bigint "sport_id", null: false
    t.bigint "bookmaker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookmaker_id"], name: "index_leagues_on_bookmaker_id"
    t.index ["name_en"], name: "index_leagues_on_name_en"
    t.index ["name_ru"], name: "index_leagues_on_name_ru"
    t.index ["slug"], name: "index_leagues_on_slug"
    t.index ["sport_id"], name: "index_leagues_on_sport_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name_ru", limit: 20, null: false
    t.string "name_en", limit: 15, null: false
    t.string "slug", limit: 15, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name_en"], name: "index_sports_on_name_en"
    t.index ["name_ru"], name: "index_sports_on_name_ru"
    t.index ["slug"], name: "index_sports_on_slug"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "bookmaker_id", null: false
    t.bigint "sport_id", null: false
    t.string "external_id"
    t.string "name_ru", limit: 20, null: false
    t.string "name_en", limit: 20, null: false
    t.string "slug", limit: 20, null: false
    t.integer "sex", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookmaker_id"], name: "index_teams_on_bookmaker_id"
    t.index ["external_id"], name: "index_teams_on_external_id"
    t.index ["name_en"], name: "index_teams_on_name_en"
    t.index ["name_ru"], name: "index_teams_on_name_ru"
    t.index ["slug"], name: "index_teams_on_slug"
    t.index ["sport_id"], name: "index_teams_on_sport_id"
  end

  add_foreign_key "events", "bookmakers"
  add_foreign_key "events", "leagues"
  add_foreign_key "events", "sports"
  add_foreign_key "leagues", "bookmakers"
  add_foreign_key "leagues", "sports"
  add_foreign_key "teams", "bookmakers"
  add_foreign_key "teams", "sports"
end
