class BudgetAccountsController < ApplicationController
  include ResponseBuilder

  before_action :set_budget_account

  def user
    current_budget = Budget.current(@budget_account)
    if current_budget.nil?
      errors = ['user has no current budget']
      render json: build_error_response(:ERROR_NOT_FOUND, errors:), status: :not_found
    else
      last_expense = current_budget.expenses.order(:created_at).last
      data = {
        budget_account: {
          current_budget: {
            uid: current_budget.uid,
            balance: current_budget.balance.to_f,
            last_expense_amount: last_expense.nil? ? nil : last_expense.amount.to_f
          }
        }
      }
      render json: build_successful_response(:SUCCESS, data:)
    end
  end

  private

  def set_budget_account
    @budget_account = current_user.budget_account
  end
end
