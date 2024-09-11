module TransactionConcern
  protected

  def credit_budget!(new_amount)
    balance = budget.balance + new_amount
    budget.update(balance:)
  end

  def debit_budget!(amount)
    balance = budget.balance - amount
    budget.update(balance:)
  end

  def increment_transaction_count!
    transaction_count = budget.transaction_count + 1
    budget.update(transaction_count:)
  end

  def decrement_transaction_count!
    transaction_count = budget.transaction_count - 1
    budget.update(transaction_count:)
  end

  module Validations
    protected

    def set_default_type
      self.transaction_type_id = budget.default_transaction_type.id
    end
  end

  module Income
    protected

    def credit_total_income!(new_amount)
      total_income = budget.total_income
      budget.update(total_income: total_income + new_amount)
    end

    def debit_total_income!(new_amount)
      total_income = budget.total_income
      budget.update(total_income: total_income - new_amount)
    end

    def increment_income_count!
      income_count = budget.income_count + 1
      budget.update(income_count:)
    end

    def decrement_income_count!
      income_count = budget.income_count - 1
      budget.update(income_count:)
    end
  end

  module Expense
    protected

    def credit_total_expense!(new_amount)
      total_expenses = budget.total_expenses
      budget.update(total_expenses: total_expenses + new_amount)
    end

    def debit_total_expense!(new_amount)
      total_expenses = budget.total_expenses
      budget.update(total_expenses: total_expenses - new_amount)
    end

    def increment_expense_count!
      expense_count = budget.expense_count + 1
      budget.update(expense_count:)
    end

    def decrement_expense_count!
      expense_count = budget.expense_count - 1
      budget.update(expense_count:)
    end
  end
end
