class UpdateTransactionTypesDefaults < ActiveRecord::Migration[7.1]
  def change
    change_column_default :transaction_types, :name, from: 'DEFAULT', to: nil
    change_column_default :transaction_types, :color, from: '#000000', to: nil
    change_column_default :transaction_types, :default, from: true, to: false
  end
end
