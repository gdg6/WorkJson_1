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

ActiveRecord::Schema.define(version: 20150517205035) do

  create_table "comments", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "daily_posts", force: true do |t|
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "adress"
    t.integer  "date"
    t.string   "time"
    t.string   "description"
    t.integer  "price"
    t.integer  "popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "url"
  end

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

  create_table "genre_tags", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "context"
    t.integer  "genre_tag_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["genre_tag_id"], name: "index_tags_on_genre_tag_id"
  add_index "tags", ["user_id"], name: "index_tags_on_user_id"

  create_table "users", force: true do |t|
    t.string   "login",                                  null: false
    t.string   "password_digest",                        null: false
    t.string   "characterName",                          null: false
    t.integer  "city",                   default: 0
    t.boolean  "admin",                  default: false
    t.string   "provider"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
  end

end
