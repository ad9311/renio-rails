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
  include BudgetSerializer
  extend BudgetConcern::ScopesMethods

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
  validate :unique_uid, on: :create

  belongs_to :budget_account
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  scope :find_current, lambda { |budget_account, incomes: false, expenses: false|
    find_current_budget(budget_account, incomes:, expenses:)
  }

  scope :find_record, lambda { |uid, incomes: false, expenses: false|
    by_uid(uid, incomes:, expenses:)
  }

  before_save :set_uid

  def self.current(budget_account, incomes: false, expenses: false)
    find_current(budget_account, incomes:, expenses:).first
  end

  def self.find_by_uid(uid, incomes: false, expenses: false)
    find_record(uid, incomes:, expenses:).first
  end

  def default_transaction_type
    budget_account.transaction_types.find_by(default: true)
  end

  private

  def uid_to_set
    "#{budget_account.id}_#{year}_#{month.to_s.rjust(2, '0')}"
  end

  def set_uid
    self.uid = uid_to_set
  end

  def unique_uid
    return unless Budget.find_by(uid: uid_to_set)

    errors.add(:uid, 'already exists for this year and month')
    throw(:abort)
  end
end
