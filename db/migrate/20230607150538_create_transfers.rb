class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.references :transaction, null: false, index: true, foreign_key: true
      t.references :recipient, null: false, index: true, foreign_key: { to_table: :users }
      t.float :amount, null: false, index: true
      
      t.timestamps
    end
  end
end
