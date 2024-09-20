# == Schema Information
#
# Table name: incomes
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(11, 2)   default(0.0), not null
#  description         :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  budget_id           :bigint           not null
#  transaction_type_id :bigint           not null
#
# Indexes
#
#  index_incomes_on_budget_id            (budget_id)
#  index_incomes_on_transaction_type_id  (transaction_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (transaction_type_id => transaction_types.id)
#
class Income < ApplicationRecord
  include TransactionConcern
  include TransactionConcern::Income
  include TransactionConcern::Validations
  include IncomeSerializer

  validates :description, presence: true, length: { minimum: 1, maximum: 150 }
  validates :amount, numericality: { greater_than: 0 }

  belongs_to :budget
  belongs_to :transaction_type

  after_create :run_after_create
  before_update :run_before_update
  after_update :run_after_update
  before_destroy :run_before_destroy

  private

  def run_after_create
    increment_transaction_count!
    credit_budget!(amount)
    credit_total_income!(amount)
    increment_income_count!
  end

  def run_before_destroy
    decrement_transaction_count!
    debit_budget!(amount)
    debit_total_income!(amount)
    decrement_income_count!
  end

  def run_before_update
    return unless amount_changed?

    debit_budget!(amount_was)
    debit_total_income!(amount_was)
  end

  def run_after_update
    return unless saved_change_to_amount?

    credit_budget!(amount)
    credit_total_income!(amount)
  end
end
