# == Schema Information
#
# Table name: transaction_types
#
#  id                :bigint           not null, primary key
#  name              :string           not null
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
  include TransactionTypeSerializer

  validates :name, length: { minimum: 1, maximum: 25 }

  belongs_to :budget_account
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy
end
