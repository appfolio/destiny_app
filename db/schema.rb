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

ActiveRecord::Schema.define(version: 20150612171308) do

  create_table "1C9EA35024EC4236A9E5DC9E645DA857_chests", force: true do |t|
    t.string   "size"
    t.string   "color"
    t.string   "key_slot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "1C9EA35024EC4236A9E5DC9E645DA857_items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "token"
    t.integer  "chest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "1C9EA35024EC4236A9E5DC9E645DA857_key_cards", force: true do |t|
    t.string   "blade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "1C9EA35024EC4236A9E5DC9E645DA857_letters", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chests", force: true do |t|
    t.string   "size"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key_slot"
  end

  create_table "gates", force: true do |t|
    t.boolean  "is_locked"
    t.string   "tables_prefix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "token"
    t.integer  "chest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "key_cards", force: true do |t|
    t.string   "blade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "letters", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",   limit: 128, default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "name"
    t.string   "mobile_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tables_prefix"
  end


   # Foreign Keys and indexes for 1C9EA35024EC4236A9E5DC9E645DA857_items
   add_index("1C9EA35024EC4236A9E5DC9E645DA857_items", ["chest_id"], :name => "index_1C9EA35024EC4236A9E5DC9E645DA857_items_on_chest_id")


   # Foreign Keys and indexes for items
   add_index("items", ["chest_id"], :name => "index_items_on_chest_id")


   # Foreign Keys and indexes for users
   add_index("users", ["authentication_token"], :unique => true, :name => "index_users_on_authentication_token")
   add_index("users", ["email"], :unique => true, :name => "index_users_on_email")

end
