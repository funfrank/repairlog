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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131007033841) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories", :force => true do |t|
    t.string "name"
    t.string "posid"
    t.string "rpts"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "contractor"
    t.string   "phone"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.integer  "enable"
    t.integer  "category_id"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "devices_repair_logs", :force => true do |t|
    t.integer "device_id"
    t.integer "repair_log_id"
    t.decimal "price",         :precision => 8, :scale => 2
  end

  create_table "failures", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "repair_logs", :force => true do |t|
    t.string   "posid"
    t.integer  "company_id"
    t.datetime "sendDate"
    t.integer  "failure_id"
    t.integer  "state_id"
    t.text     "note"
    t.text     "sendNote"
    t.integer  "operator_id"
    t.datetime "stateDate"
    t.integer  "category_id"
    t.integer  "area_id"
    t.decimal  "cost",        :precision => 8, :scale => 2
    t.string   "contractor"
    t.string   "phone"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "role_states", :force => true do |t|
    t.integer "category_id"
    t.integer "role_id"
    t.integer "state_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "rpts", :force => true do |t|
    t.integer "user_id"
    t.integer "state_id"
    t.integer "times"
    t.integer "is_helper"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "states", :force => true do |t|
    t.string  "name"
    t.integer "next_id"
    t.integer "control"
    t.integer "view"
    t.integer "category_id"
  end

  create_table "states_repair_logs", :force => true do |t|
    t.integer  "state_id"
    t.integer  "repair_log_id"
    t.integer  "user_id"
    t.integer  "user2_id"
    t.datetime "date"
  end

  create_table "stock_logs", :force => true do |t|
    t.integer  "device_id"
    t.integer  "in_area_id"
    t.integer  "out_area_id"
    t.integer  "amount"
    t.datetime "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stocks", :force => true do |t|
    t.integer  "device_id"
    t.integer  "area_id"
    t.integer  "rest"
    t.integer  "warning"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "password"
    t.integer  "role_id"
    t.integer  "category_id"
    t.integer  "area_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
