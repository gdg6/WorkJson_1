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

ActiveRecord::Schema.define(version: 20150502215304) do

  create_table "comments", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "Body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.string   "Name"
    t.string   "Adress"
    t.string   "Date"
    t.string   "Time"
    t.string   "Description"
    t.integer  "Price"
    t.integer  "Popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "Image_file_name"
    t.string   "Image_content_type"
    t.integer  "Image_file_size"
    t.datetime "Image_updated_at"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "users", force: true do |t|
    t.string   "login",                                  null: false
    t.string   "password_digest",                        null: false
    t.string   "characterName",                          null: false
    t.string   "city"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

end
