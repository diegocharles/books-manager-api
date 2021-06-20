class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.decimal :fee, precision: 10, scale: 2
      t.datetime :loaned_at
      t.datetime :returned_at

      t.timestamps
    end
  end
end
