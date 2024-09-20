class RemoveColorFromTransactionTypes < ActiveRecord::Migration[7.1]
  def change
    remove_column :transaction_types, :color
  end
end
