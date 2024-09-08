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

ActiveRecord::Schema[7.1].define(version: 2024_09_08_143016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowlisted_jwts", force: :cascade do |t|
    t.string "jti", null: false
    t.string "aud"
    t.datetime "exp", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "budget_accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_budget_accounts_on_user_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.bigint "budget_account_id", null: false
    t.string "uid", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.decimal "balance", precision: 11, scale: 2, default: "0.0", null: false
    t.decimal "total_income", precision: 11, scale: 2, default: "0.0", null: false
    t.decimal "total_expenses", precision: 11, scale: 2, default: "0.0", null: false
    t.integer "transaction_count", default: 0, null: false
    t.integer "income_count", default: 0, null: false
    t.integer "expense_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_account_id"], name: "index_budgets_on_budget_account_id"
    t.index ["uid"], name: "index_budgets_on_uid", unique: true
  end

  create_table "incomes", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.bigint "transaction_type_id", null: false
    t.string "description", null: false
    t.decimal "amount", precision: 11, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_incomes_on_budget_id"
    t.index ["transaction_type_id"], name: "index_incomes_on_transaction_type_id"
  end

  create_table "transaction_types", force: :cascade do |t|
    t.bigint "budget_account_id", null: false
    t.string "name", default: "DEFAULT", null: false
    t.boolean "default", default: true, null: false
    t.string "color", default: "#000000", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_account_id"], name: "index_transaction_types_on_budget_account_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string "name", null: false
    t.string "username", null: false
    t.text "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
  add_foreign_key "budget_accounts", "users"
  add_foreign_key "budgets", "budget_accounts"
  add_foreign_key "incomes", "budgets"
  add_foreign_key "incomes", "transaction_types"
  add_foreign_key "transaction_types", "budget_accounts"
end
