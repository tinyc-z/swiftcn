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

ActiveRecord::Schema.define(version: 20160521231139) do

  create_table "appends", force: :cascade do |t|
    t.integer  "topic_id",   limit: 4
    t.text     "content",    limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "appends", ["topic_id"], name: "index_appends_on_topic_id", using: :btree

  create_table "attentions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "topic_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "attentions", ["topic_id"], name: "index_attentions_on_topic_id", using: :btree
  add_index "attentions", ["user_id"], name: "index_attentions_on_user_id", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "uid",          limit: 4
    t.string   "provider",     limit: 191, null: false
    t.string   "access_token", limit: 191
    t.datetime "expires_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "uname",        limit: 191
    t.string   "provider_url", limit: 191
    t.string   "avatar_url",   limit: 191
  end

  add_index "authentications", ["access_token"], name: "index_authentications_on_access_token", using: :btree
  add_index "authentications", ["uid"], name: "index_authentications_on_uid", using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "event_logs", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "entity_id",   limit: 191
    t.string   "entity_type", limit: 191
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "event_logs", ["user_id"], name: "index_event_logs_on_user_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "topic_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "favorites", ["topic_id"], name: "index_favorites_on_topic_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "title",      limit: 191
    t.string   "link",       limit: 191
    t.string   "cover",      limit: 191
    t.integer  "sort",       limit: 4,   default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "name",           limit: 191
    t.string   "slug",           limit: 191
    t.integer  "parent_node_id", limit: 4
    t.integer  "topics_count",   limit: 4,   default: 0
    t.integer  "sort",           limit: 4,   default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.datetime "deleted_at"
  end

  add_index "nodes", ["name"], name: "index_nodes_on_name", using: :btree
  add_index "nodes", ["parent_node_id"], name: "index_nodes_on_parent_node_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "from_user_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.integer  "topic_id",     limit: 4
    t.integer  "entity_id",    limit: 4
    t.text     "body",         limit: 65535
    t.string   "notify_type",  limit: 191
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "body_digest",  limit: 65535
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "image",      limit: 191, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "topic_id",      limit: 4
    t.text     "body",          limit: 65535
    t.text     "body_original", limit: 65535
    t.boolean  "is_blocked",                  default: false
    t.integer  "votes_count",   limit: 4,     default: 0
    t.datetime "deleted_at"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "replies", ["topic_id"], name: "index_replies_on_topic_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 191
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "site_statuses", force: :cascade do |t|
    t.datetime "day_at"
    t.integer  "user_count",  limit: 4, default: 0
    t.integer  "topic_count", limit: 4, default: 0
    t.integer  "reply_count", limit: 4, default: 0
    t.integer  "photo_count", limit: 4, default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "vote_count",  limit: 4, default: 0
  end

  create_table "tips", force: :cascade do |t|
    t.string   "body",       limit: 191
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title",              limit: 191,                   null: false
    t.text     "body",               limit: 65535
    t.text     "body_original",      limit: 65535
    t.text     "excerpt",            limit: 65535
    t.boolean  "is_excellent",                     default: false
    t.boolean  "is_wiki",                          default: false
    t.boolean  "is_blocked",                       default: false
    t.integer  "replies_count",      limit: 4,     default: 0
    t.integer  "view_count",         limit: 4,     default: 0
    t.integer  "favorites_count",    limit: 4,     default: 0
    t.integer  "votes_count",        limit: 4,     default: 0
    t.integer  "last_reply_user_id", limit: 4
    t.integer  "order",              limit: 4,     default: 0
    t.integer  "node_id",            limit: 4,                     null: false
    t.integer  "user_id",            limit: 4,                     null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.datetime "deleted_at"
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                     limit: 191, default: "",    null: false
    t.string   "encrypted_password",        limit: 191, default: "",    null: false
    t.string   "name",                      limit: 191,                 null: false
    t.boolean  "is_banned",                             default: false, null: false
    t.string   "avatar",                    limit: 191
    t.string   "password",                  limit: 191, default: "0",   null: false
    t.integer  "topics_count",              limit: 4,   default: 0,     null: false
    t.integer  "replies_count",             limit: 4,   default: 0,     null: false
    t.integer  "notifications_count",       limit: 4,   default: 0,     null: false
    t.string   "city",                      limit: 191
    t.string   "company",                   limit: 191
    t.string   "twitter_account",           limit: 191
    t.string   "personal_website",          limit: 191
    t.string   "signature",                 limit: 191
    t.string   "introduction",              limit: 191
    t.datetime "deleted_at"
    t.string   "reset_password_token",      limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",        limit: 191
    t.string   "last_sign_in_ip",           limit: 191
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "role_id",                   limit: 4
    t.integer  "unread_notification_count", limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 191
    t.string   "is",           limit: 191
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree
  add_index "votes", ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree

  add_foreign_key "users", "roles"
end
