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

ActiveRecord::Schema[7.0].define(version: 2023_06_07_150754) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "balance", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["balance"], name: "index_balances_on_balance"
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "stock_transactions", force: :cascade do |t|
    t.bigint "transaction_id", null: false
    t.bigint "stock_id", null: false
    t.datetime "stock_pricing_time", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amount"], name: "index_stock_transactions_on_amount"
    t.index ["stock_id"], name: "index_stock_transactions_on_stock_id"
    t.index ["stock_pricing_time"], name: "index_stock_transactions_on_stock_pricing_time"
    t.index ["transaction_id"], name: "index_stock_transactions_on_transaction_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "action", null: false
    t.float "debit", default: 0.0, null: false
    t.float "credit", default: 0.0, null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action"], name: "index_transactions_on_action"
    t.index ["credit"], name: "index_transactions_on_credit"
    t.index ["debit"], name: "index_transactions_on_debit"
    t.index ["status"], name: "index_transactions_on_status"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "transaction_id", null: false
    t.bigint "recipient_id", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amount"], name: "index_transfers_on_amount"
    t.index ["recipient_id"], name: "index_transfers_on_recipient_id"
    t.index ["transaction_id"], name: "index_transfers_on_transaction_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "balances", "users"
  add_foreign_key "stock_transactions", "stocks"
  add_foreign_key "stock_transactions", "transactions"
  add_foreign_key "transfers", "transactions"
  add_foreign_key "transfers", "users", column: "recipient_id"
end
