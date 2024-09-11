# == Schema Information
#
# Table name: transaction_types
#
#  id                :bigint           not null, primary key
#  color             :string           not null
#  default           :boolean          default(FALSE), not null
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
  validates :color, length: { is: 7 }

  belongs_to :budget_account
  has_many :incomes, dependent: :nullify
  has_many :expenses, dependent: :nullify

  before_destroy :transfer_transactions_to_default, prepend: true
  before_destroy :prevent_default_deletion, prepend: true

  def default?
    default
  end

  private

  def prevent_default_deletion
    throw(:abort) if default?
  end

  def transfer_transactions_to_default
    default_transaction_type = budget_account.transaction_types.find_by(default: true)
    incomes.each do |income|
      income.update(transaction_type: default_transaction_type)
    end
    expenses.each do |expense|
      expense.update(transaction_type: default_transaction_type)
    end
  end
end
