class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, index: true
      t.string :external_id, index: true
      t.string :password_digest
      t.decimal :amount, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
