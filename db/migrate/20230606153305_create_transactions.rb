class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, index: true
      t.references :action, null: false, index: true
      t.float :debit, null: false, default: 0, index: true
      t.float :credit, null: false, default: 0, index: true

      t.timestamps
    end
  end
end
