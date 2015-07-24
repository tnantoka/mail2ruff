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

ActiveRecord::Schema.define(version: 20150723065605) do

  create_table "addresses", force: :cascade do |t|
    t.string   "uid",        limit: 255, null: false
    t.integer  "note_id",    limit: 4,   null: false
    t.integer  "page_id",    limit: 4
    t.string   "team",       limit: 255, null: false
    t.string   "note",       limit: 255, null: false
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "token",      limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "addresses", ["note_id", "user_id"], name: "index_addresses_on_note_id_and_user_id", unique: true, using: :btree
  add_index "addresses", ["uid"], name: "index_addresses_on_uid", unique: true, using: :btree

end
