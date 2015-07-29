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

ActiveRecord::Schema.define(version: 20150728184503) do

  create_table "59A1C2C0FBB74AF8BC12C3CA1FE1FE63_chests", force: true do |t|
    t.string   "size"
    t.string   "color"
    t.string   "key_slot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "59A1C2C0FBB74AF8BC12C3CA1FE1FE63_key_cards", force: true do |t|
    t.string   "blade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "59A1C2C0FBB74AF8BC12C3CA1FE1FE63_letters", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "59a1c2c0fbb74af8bc12c3ca1fe1fe63_items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "token"
    t.integer  "chest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "59a1c2c0fbb74af8bc12c3ca1fe1fe63_items", ["chest_id"], name: "index_59A1C2C0FBB74AF8BC12C3CA1FE1FE63_items_on_chest_id", using: :btree

  create_table "8_reference_letters", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "9_reference_letters", force: true do |t|
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

  add_index "items", ["chest_id"], name: "index_items_on_chest_id", using: :btree

  create_table "key_cards", force: true do |t|
    t.string   "blade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                              default: "",    null: false
    t.string   "encrypted_password",     limit: 128, default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "mobile_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tables_prefix"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "csrf_email_read",                    default: false, null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
