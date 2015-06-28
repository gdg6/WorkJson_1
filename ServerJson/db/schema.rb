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

ActiveRecord::Schema.define(version: 20150627182527) do

  create_table "admins", force: true do |t|
    t.string   "login"
    t.string   "password_digest", null: false
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "body",       null: false
    t.string   "login",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "daily_posts", force: true do |t|
    t.string   "context"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daily_posts", ["city_id"], name: "index_daily_posts_on_city_id"

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "adress"
    t.integer  "date"
    t.string   "time"
    t.string   "description",          limit: 300
    t.integer  "price"
    t.integer  "popularity"
    t.integer  "city_id"
    t.string   "url"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["city_id"], name: "index_events_on_city_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "events_to_tags", force: true do |t|
    t.integer  "event_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events_to_tags", ["event_id"], name: "index_events_to_tags_on_event_id"
  add_index "events_to_tags", ["tag_id"], name: "index_events_to_tags_on_tag_id"

  create_table "favorities", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorities", ["event_id"], name: "index_favorities_on_event_id"
  add_index "favorities", ["user_id"], name: "index_favorities_on_user_id"

  create_table "tags", force: true do |t|
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_to_characters", force: true do |t|
    t.integer  "tag_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags_to_characters", ["character_id"], name: "index_tags_to_characters_on_character_id"
  add_index "tags_to_characters", ["tag_id"], name: "index_tags_to_characters_on_tag_id"

  create_table "users", force: true do |t|
    t.string   "login",                                 null: false
    t.string   "password_digest",                       null: false
    t.integer  "character_id",                          null: false
    t.integer  "city_id"
    t.boolean  "active",                 default: true
    t.string   "provider"
    t.integer  "provider_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
  end

  add_index "users", ["character_id"], name: "index_users_on_character_id"
  add_index "users", ["city_id"], name: "index_users_on_city_id"

end
