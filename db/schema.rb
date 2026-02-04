# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_02_04_142957) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "app_notifications", force: :cascade do |t|
    t.bigint "app_id", null: false
    t.datetime "created_at", null: false
    t.boolean "level_error", default: false
    t.boolean "level_info", default: false
    t.boolean "level_warning", default: false
    t.bigint "notification_id", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id", "notification_id"], name: "index_app_notifications_on_app_id_and_notification_id", unique: true
    t.index ["app_id"], name: "index_app_notifications_on_app_id"
    t.index ["notification_id"], name: "index_app_notifications_on_notification_id"
  end

  create_table "apps", force: :cascade do |t|
    t.string "api_key", null: false
    t.datetime "created_at", null: false
    t.datetime "last_used_at"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_apps_on_api_key", unique: true
    t.index ["name"], name: "index_apps_on_name", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "attempts", default: 0, null: false
    t.datetime "created_at"
    t.datetime "failed_at"
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "locked_at"
    t.string "locked_by"
    t.integer "priority", default: 0, null: false
    t.string "queue"
    t.datetime "run_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "app_id", null: false
    t.text "backtrace"
    t.text "context"
    t.datetime "created_at", null: false
    t.string "level", null: false
    t.string "message", null: false
    t.datetime "occurred_at", null: false
    t.datetime "readed_at"
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_messages_on_app_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.jsonb "configuration", default: {}, null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "service", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "default_theme", default: "dark", null: false
    t.string "language", default: "en", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "app_notifications", "apps"
  add_foreign_key "app_notifications", "notifications"
  add_foreign_key "messages", "apps"
end
