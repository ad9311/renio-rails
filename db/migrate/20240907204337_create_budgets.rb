class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.references :budget_account, null: false, foreign_key: true

      t.string :uid, null: false
      t.integer :year, null: false
      t.integer :month, null: false

      t.decimal :balance, precision: 11, scale: 2, null: false, default: 0.0
      t.decimal :total_income, precision: 11, scale: 2, null: false, default: 0.0
      t.decimal :total_expenses, precision: 11, scale: 2, null: false, default: 0.0

      t.integer :transaction_count, null: false, default: 0
      t.integer :income_count, null: false, default: 0
      t.integer :expense_count, null: false, default: 0

      t.timestamps
    end

    add_index :budgets, :uid, unique: true
  end
end
