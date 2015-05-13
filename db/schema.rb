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

ActiveRecord::Schema.define(version: 20150512212907) do

  create_table "auctions", force: :cascade do |t|
    t.decimal  "reserve",                precision: 7, scale: 2
    t.boolean  "show_reserve", limit: 1,                         default: false
    t.integer  "listing_id",   limit: 4
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  add_index "auctions", ["listing_id"], name: "index_auctions_on_listing_id", using: :btree

  create_table "bids", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "listing_id", limit: 4
    t.decimal  "price",                precision: 7, scale: 2
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "bids", ["listing_id"], name: "index_bids_on_listing_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "listing_id",           limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size",    limit: 4
    t.datetime "picture_updated_at"
  end

  add_index "images", ["listing_id"], name: "index_images_on_listing_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.string   "sell_method",     limit: 255
    t.integer  "sub_category_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "bids_count",      limit: 4,     default: 0, null: false
    t.datetime "end_date"
  end

  add_index "listings", ["sub_category_id"], name: "index_listings_on_sub_category_id", using: :btree
  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "price_fades", force: :cascade do |t|
    t.decimal  "start_price",               precision: 7, scale: 2
    t.decimal  "price_decrement",           precision: 7, scale: 2
    t.integer  "listing_id",      limit: 4
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.integer  "price_interval",  limit: 4
    t.boolean  "sale_pending",    limit: 1,                         default: false
  end

  add_index "price_fades", ["listing_id"], name: "index_price_fades_on_listing_id", using: :btree

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "category_id",    limit: 4
    t.integer  "listings_count", limit: 4,   default: 0, null: false
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
