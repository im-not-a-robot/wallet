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

ActiveRecord::Schema[7.0].define(version: 2023_06_07_150538) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "balances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "amount", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amount"], name: "index_balances_on_amount"
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "action_id", null: false
    t.float "debit", default: 0.0, null: false
    t.float "credit", default: 0.0, null: false
    t.bigint "ref_transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_id"], name: "index_transactions_on_action_id"
    t.index ["credit"], name: "index_transactions_on_credit"
    t.index ["debit"], name: "index_transactions_on_debit"
    t.index ["ref_transaction_id"], name: "index_transactions_on_ref_transaction_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "ref_transaction_id", null: false
    t.bigint "recipient_id", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amount"], name: "index_transfers_on_amount"
    t.index ["recipient_id"], name: "index_transfers_on_recipient_id"
    t.index ["ref_transaction_id"], name: "index_transfers_on_ref_transaction_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "balances", "users"
  add_foreign_key "transactions", "transactions", column: "ref_transaction_id"
  add_foreign_key "transfers", "transactions", column: "ref_transaction_id"
  add_foreign_key "transfers", "users", column: "recipient_id"
end
