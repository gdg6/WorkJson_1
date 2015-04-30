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

ActiveRecord::Schema.define(version: 20150430200346) do

  create_table "comments", force: true do |t|
    t.integer  "OwnerUser"
    t.string   "Body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "EventId"
    t.string   "Name"
    t.string   "Adress"
    t.string   "Date"
    t.string   "Time"
    t.string   "Description"
    t.integer  "Price"
    t.integer  "Popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "UserId"
    t.string   "Login",           null: false
    t.string   "Email",           null: false
    t.string   "password_digest", null: false
    t.string   "CharacterName",   null: false
    t.string   "City",            null: false
    t.boolean  "Admin",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
