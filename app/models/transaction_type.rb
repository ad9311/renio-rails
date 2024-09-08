# == Schema Information
#
# Table name: transaction_types
#
#  id                :bigint           not null, primary key
#  color             :string           default("#000000"), not null
#  default           :boolean          default(TRUE), not null
#  name              :string           default("DEFAULT"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  budget_account_id :bigint           not null
#
# Indexes
#
#  index_transaction_types_on_budget_account_id  (budget_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_account_id => budget_accounts.id)
#
class TransactionType < ApplicationRecord
  belongs_to :budget_account
  has_many :incomes, dependent: :destroy
end
