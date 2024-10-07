module BudgetAccountSerializer
  include Serializer

  private

  def attributes(_options = {})
    data = { id:, current_budget: nil }
    current_budget = Budget.current(self)
    return dara if current_budget.nil?

    last_expense = current_budget.expenses.order(:created_at).last
    last_expense_amount = last_expense.nil? ? nil : last_expense.amount.to_f
    current_budget_data = {
      uid: current_budget.uid,
      balance: current_budget.balance.to_f,
      last_expense_amount:
    }
    data.merge({ current_budget: current_budget_data })
  end
end
