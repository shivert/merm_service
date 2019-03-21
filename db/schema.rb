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

ActiveRecord::Schema.define(version: 20190320174331) do

  create_table "categories", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "name", null: false
    t.integer "rank", null: false
    t.boolean "custom", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "author_id"
    t.integer "merm_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.integer "merm_id"
    t.string "name"
    t.string "url"
    t.datetime "visit_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merms", force: :cascade do |t|
    t.string "name"
    t.string "resource_name"
    t.boolean "favorite", default: false, null: false
    t.string "resource_url"
    t.integer "owner_id"
    t.integer "category_id"
    t.string "content_type"
    t.string "source"
    t.string "description"
    t.string "captured_text"
    t.datetime "last_accessed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "archived", default: false, null: false
    t.boolean "expired", default: false, null: false
    t.datetime "expiry_date"
    t.index ["deleted_at"], name: "index_merms_on_deleted_at"
  end

  create_table "shares", force: :cascade do |t|
    t.integer "merm_id"
    t.integer "sharer_id"
    t.integer "shared_with_id"
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer "merm_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_tags_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
