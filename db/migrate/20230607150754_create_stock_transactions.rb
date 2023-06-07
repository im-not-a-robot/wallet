class CreateStockTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_transactions do |t|
      t.references :transaction, null: false, foreign_key: true, index: true
      t.references :stock, null: false, foreign_key: true, index: true
      t.datetime :stock_pricing_time, null: false, index: true
      t.float :amount, null: false, index: true
      
      t.timestamps
    end
  end
end
