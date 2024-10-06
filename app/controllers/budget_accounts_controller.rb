class BudgetAccountsController < ApplicationController
  include ResponseBuilder

  before_action :set_budget_account

  def index
    data = {}
    response = build_successful_response(:SUCCESS, data:)
    render json: response
  end

  private

  def set_budget_account
    @budget_account = current_user.budget_account
  end
end
