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

  create_table "12_reference_letters", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "14ECDCF23CBF41618D9BEF9FC5A9CE15_chests", force: true do |t|
    t.string   "size"
    t.string   "color"
    t.string   "key_slot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "14ECDCF23CBF41618D9BEF9FC5A9CE15_items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "token"
    t.integer  "chest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "14ecdcf23cbf41618d9bef9fc5a9ce15_items", ["chest_id"], name: "index_14ECDCF23CBF41618D9BEF9FC5A9CE15_items_on_chest_id", using: :btree

  create_table "14ECDCF23CBF41618D9BEF9FC5A9CE15_key_cards", force: true do |t|
    t.string   "blade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "14ECDCF23CBF41618D9BEF9FC5A9CE15_letters", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "2F84B0244D2E45ABA5EF7BD8B5F85509_chests", force: true do |t|
    t.string   "size"
    t.string   "color"
    t.string   "key_slot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "2F84B0244D2E45ABA5EF7BD8B5F85509_items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "token"
    t.integer  "chest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "2f84b0244d2e45aba5ef7bd8b5f85509_items", ["chest_id"], name: "index_2F84B0244D2E45ABA5EF7BD8B5F85509_items_on_chest_id", using: :btree

  create_table "2F84B0244D2E45ABA5EF7BD8B5F85509_key_cards", force: true do |t|
    t.string   "blade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "2F84B0244D2E45ABA5EF7BD8B5F85509_letters", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tables_prefix"
    t.boolean  "csrf_email_read",                    default: false, null: false
    t.string   "mobile_number"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
