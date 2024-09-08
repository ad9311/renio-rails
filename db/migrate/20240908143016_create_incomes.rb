class CreateIncomes < ActiveRecord::Migration[7.1]
  def change
    create_table :incomes do |t|
      t.references :budget, null: false, foreign_key: true
      t.references :transaction_type, null: false, foreign_key: true
      t.string :description, null: false
      t.decimal :amount, precision: 11, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
