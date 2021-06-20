class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :external_id
      t.integer :units, default: 0
      t.integer :active_loans, default: 0
      t.integer :loan_fee, precision: 8, scale: 2

      t.timestamps
    end
  end
end
