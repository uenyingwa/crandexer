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

ActiveRecord::Schema.define(version: 2021_09_15_212356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "packages", force: :cascade do |t|
    t.jsonb "author"
    t.text "description"
    t.jsonb "maintainer"
    t.string "name", null: false
    t.datetime "published_at"
    t.string "title"
    t.string "version", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_packages_on_name"
    t.index ["version"], name: "index_packages_on_version"
  end

end
