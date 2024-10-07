class BudgetAccountsController < ApplicationController
  include ResponseBuilder

  before_action :set_budget_account

  def user
    current_budget = Budget.current(@budget_account)
    if current_budget.nil?
      errors = ['user has no current budget']
      response = build_error_response(:ERROR_NOT_FOUND, errors:)

      render json: response, status: :not_found
    else
      data = { budget_account: @budget_account.serialized_hash }
      response = build_successful_response(:SUCCESS, data:)

      render json: response
    end
  end

  private

  def set_budget_account
    @budget_account = current_user.budget_account
  end
end
