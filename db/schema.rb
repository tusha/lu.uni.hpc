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

ActiveRecord::Schema.define(version: 20130828100150) do

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "script_name"
    t.string   "script_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
    t.string   "tokens",      limit: 50, array: true
  end

  create_table "addresses", force: true do |t|
    t.integer  "user_id"
    t.string   "street"
    t.string   "number"
    t.string   "city"
    t.string   "country_code"
    t.string   "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "script_id"
    t.string   "tokens",          limit: 50, array: true
    t.string   "optional_params",            array: true
    t.integer  "output_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.string   "transaction_id"
    t.string   "params",         limit: 1000
    t.string   "send_money"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_token"
    t.string   "payerid",        limit: 100
    t.integer  "token_id"
    t.string   "status",         limit: 50
    t.string   "error",          limit: 800
  end

  create_table "platforms", force: true do |t|
    t.datetime "date"
    t.string   "name"
    t.integer  "nodes_num"
    t.integer  "cores_num"
    t.integer  "cores_free"
    t.integer  "cores_used"
    t.integer  "cores_reserved"
    t.integer  "cores_suspended"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "tokens", force: true do |t|
    t.string   "quality"
    t.integer  "generation_num"
    t.integer  "transform_num"
    t.string   "kind"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_token"
    t.boolean  "isdefault",      default: false
  end

  create_table "user_sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["session_id"], name: "index_user_sessions_on_session_id", using: :btree
  add_index "user_sessions", ["updated_at"], name: "index_user_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "kind"
    t.string   "email"
    t.string   "phonenumber"
    t.string   "mobile"
    t.string   "password_salt"
    t.integer  "id_account"
    t.integer  "id_address"
    t.boolean  "isactive"
    t.integer  "loginretries"
    t.string   "secretquestion"
    t.string   "secretanswer"
    t.datetime "lastlogindate"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "role",              default: "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["lastlogindate"], name: "index_users_on_lastlogindate", using: :btree
  add_index "users", ["persistence_token"], name: "index_users_on_persistence_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "vs_database_diagrams", id: false, force: true do |t|
    t.string   "name",     limit: 80
    t.text     "diadata"
    t.string   "comment",  limit: 1022
    t.text     "preview"
    t.string   "lockinfo", limit: 80
    t.datetime "locktime"
    t.string   "version",  limit: 80
  end

end
