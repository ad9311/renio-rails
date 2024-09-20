class RemoveDefaultFromTransactionTypes < ActiveRecord::Migration[7.1]
  def change
    remove_column :transaction_types, :default
  end
end
