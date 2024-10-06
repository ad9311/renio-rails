class BudgetAccountsController < ApplicationController
  include ResponseBuilder

  before_action :set_budget_account

  def user
    current_budget = Budget.current(@budget_account)
    data = {
      budget_account: {
        current_budget: {
          uid: current_budget.uid,
          balance: current_budget.balance,
          last_expense_amount: current_budget.expenses.order(:created_at).last
        }
      }
    }
    response = build_successful_response(:SUCCESS, data:)
    render json: response
  end

  private

  def set_budget_account
    @budget_account = current_user.budget_account
  end
end
