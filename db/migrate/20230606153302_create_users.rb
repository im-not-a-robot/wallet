class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :name, null: false
      t.string :password_digest, null: false
      t.string :role, null: false, index: true

      t.timestamps
    end
  end
end
