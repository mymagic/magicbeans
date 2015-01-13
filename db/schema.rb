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

ActiveRecord::Schema.define(version: 20150113065043) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.string   "venue"
    t.text     "description"
    t.string   "speaker"
    t.text     "speakerbio"
    t.string   "biolink"
    t.string   "keytakeaway"
    t.text     "prerequisite"
    t.integer  "maxattendee"
    t.string   "tags"
    t.string   "resources"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_id"
    t.datetime "end_date"
    t.boolean  "listed",       default: true
    t.boolean  "online",       default: true
    t.integer  "event_id"
  end

  add_index "activities", ["program_id"], name: "index_activities_on_program_id"

  create_table "logs", force: true do |t|
    t.string   "title"
    t.string   "log_type"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.text     "description", limit: 255
    t.string   "speaker"
    t.string   "speakerbio"
    t.string   "biourl"
    t.string   "keytakeways"
    t.string   "tags"
    t.string   "resources"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id"

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true

  create_table "tokens", force: true do |t|
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "ic"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmable_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_out"
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
