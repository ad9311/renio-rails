class AddUniqueIndexToTransactionTypesName < ActiveRecord::Migration[7.1]
  def change
    add_index :transaction_types, :name, unique: true
  end
end
