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

ActiveRecord::Schema.define(version: 20161123202153) do

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "valid_to"
    t.integer  "clicks",      default: 0
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["category_id"], name: "index_announcements_on_category_id"
    t.index ["user_id"], name: "index_announcements_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "source_string"
    t.integer  "announcement_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["announcement_id"], name: "index_images_on_announcement_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "rank",            default: 0
    t.text     "comment"
    t.integer  "announcement_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "author",          default: "Annonymous"
    t.index ["announcement_id"], name: "index_ratings_on_announcement_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "role"
  end

end
