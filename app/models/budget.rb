# == Schema Information
#
# Table name: budgets
#
#  id                :bigint           not null, primary key
#  balance           :decimal(11, 2)   default(0.0), not null
#  expense_count     :integer          default(0), not null
#  income_count      :integer          default(0), not null
#  month             :integer          not null
#  total_expenses    :decimal(11, 2)   default(0.0), not null
#  total_income      :decimal(11, 2)   default(0.0), not null
#  transaction_count :integer          default(0), not null
#  uid               :string           not null
#  year              :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  budget_account_id :bigint           not null
#
# Indexes
#
#  index_budgets_on_budget_account_id  (budget_account_id)
#  index_budgets_on_uid                (uid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (budget_account_id => budget_accounts.id)
#
class Budget < ApplicationRecord
  validates :uid, uniqueness: true
  validates :balance, numericality: true
  validates(
    :year,
    numericality: { only_integer: true, greater_than_or_equal_to: 2000, less_than_or_equal_to: Time.zone.now.year }
  )
  validates(
    :month,
    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  )

  belongs_to :budget_account
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  before_save :set_uid

  private

  def set_uid
    self.uid = "#{budget_account.id}_#{year}_#{month.to_s.rjust(2, '0')}"
  end
end
