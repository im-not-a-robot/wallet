class CreateBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :balances do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.float :balance, null: false, default: 0, index: true

      t.timestamps
    end
  end
end
