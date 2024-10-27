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

ActiveRecord::Schema[7.2].define(version: 2024_10_27_095340) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "recurring_interval_enum", ["day", "month", "week", "year"]
  create_enum "session_payment_status", ["no_payment_required", "paid", "unpaid"]
  create_enum "session_status", ["open", "complete", "expired"]

  create_table "bundles", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "bundle_id", null: false
    t.string "name", null: false
    t.string "description"
    t.integer "price", null: false
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "recurring_type", default: "month", null: false, enum_type: "recurring_interval_enum"
    t.index ["bundle_id"], name: "index_bundles_on_bundle_id", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.string "payment_session_id", null: false
    t.enum "payment_status", default: "unpaid", null: false, enum_type: "session_payment_status"
    t.enum "status", default: "open", null: false, enum_type: "session_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bundle_id", null: false
    t.bigint "user_id", null: false
    t.datetime "fulfillment_date"
    t.index ["bundle_id"], name: "index_orders_on_bundle_id"
    t.index ["payment_session_id"], name: "index_orders_on_payment_session_id", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "orders", "bundles"
  add_foreign_key "orders", "users"
end
