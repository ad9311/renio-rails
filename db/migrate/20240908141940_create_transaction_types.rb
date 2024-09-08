class CreateTransactionTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_types do |t|
      t.references :budget_account, null: false, foreign_key: true
      t.string :name, null: false, default: 'DEFAULT'
      t.boolean :default, null: false, default: true
      t.string :color, null: false, default: '#000000'

      t.timestamps
    end
  end
end
