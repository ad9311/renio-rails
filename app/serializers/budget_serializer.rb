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
module BudgetSerializer
  include Serializer

  private

  def attributes(options = {})
    data = {
      id:,
      uid:,
      year:,
      month:,
      balance:,
      total_income:,
      total_expenses:,
      transaction_count:,
      income_count:,
      expense_count:
    }

    if options[:income]
      income_list = incomes.map(&:serialized_hash)
      data = data.merge({ income_list: })
    end

    if options[:expenses]
      expenses = self.expenses.map(&:serialized_hash)
      data = data.merge({ expenses: })
    end

    data
  end
end
