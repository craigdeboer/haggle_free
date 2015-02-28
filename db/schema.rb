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

ActiveRecord::Schema.define(version: 20150226233016) do

  create_table "auctions", force: :cascade do |t|
    t.decimal  "reserve",                precision: 7, scale: 2
    t.boolean  "show_reserve", limit: 1
    t.datetime "end_date"
    t.integer  "listing_id",   limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "auctions", ["listing_id"], name: "index_auctions_on_listing_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "listings", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.string   "sell_method",     limit: 255
    t.date     "post_date"
    t.integer  "sub_category_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "listings", ["sub_category_id"], name: "index_listings_on_sub_category_id", using: :btree
  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "price_fades", force: :cascade do |t|
    t.decimal  "start_price",           precision: 7, scale: 2
    t.decimal  "end_price",             precision: 7, scale: 2
    t.datetime "end_date"
    t.integer  "listing_id",  limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "price_fades", ["listing_id"], name: "index_price_fades_on_listing_id", using: :btree

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "category_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "user_name",       limit: 255
    t.string   "email",           limit: 255
    t.boolean  "admin",           limit: 1,   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "password_digest", limit: 255
    t.string   "remember_digest", limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree

end
