class AddUidToTransactionTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :transaction_types, :uid, :string, null: false
    add_index :transaction_types, :uid, unique: true
  end
end
