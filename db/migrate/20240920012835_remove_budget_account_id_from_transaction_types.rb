class RemoveBudgetAccountIdFromTransactionTypes < ActiveRecord::Migration[7.1]
  def change
    remove_reference :transaction_types, :budget_account, foreign_key: true
  end
end
