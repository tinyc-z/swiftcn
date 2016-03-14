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

ActiveRecord::Schema.define(version: 20160313073410) do

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "uid",          limit: 4
    t.string   "provider",     limit: 190, null: false
    t.string   "access_token", limit: 190
    t.datetime "expires_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "authentications", ["access_token"], name: "index_authentications_on_access_token", using: :btree
  add_index "authentications", ["uid"], name: "index_authentications_on_uid", using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 190, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "name",                   limit: 190,                 null: false
    t.boolean  "is_banned",                          default: false, null: false
    t.string   "avatar",                 limit: 255
    t.string   "password",               limit: 255, default: "0",   null: false
    t.integer  "topic_count",            limit: 4,   default: 0,     null: false
    t.integer  "reply_count",            limit: 4,   default: 0,     null: false
    t.integer  "notification_count",     limit: 4,   default: 0,     null: false
    t.string   "city",                   limit: 255
    t.string   "company",                limit: 255
    t.string   "twitter_account",        limit: 255
    t.string   "personal_website",       limit: 255
    t.string   "signature",              limit: 255
    t.string   "introduction",           limit: 255
    t.datetime "deleted_at"
    t.string   "reset_password_token",   limit: 190
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
