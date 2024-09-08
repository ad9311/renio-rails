class BudgetsController < ApplicationController
  include Api::ResponseBuilder

  before_action :set_budget_account
  before_action :set_budget, only: %i[show]

  def index
    budgets = @budget_account.budgets
    data = { budgets: budgets.map(&:serialized_hash) }
    response = build_successful_response(:SUCCESS, data:)

    render json: response, status: :created
  end

  def show
    if @budget.nil?
      errors = ["budget not found with uid '#{params[:uid]}'"]
      response = build_error_response(:NOT_FOUND, errors:)

      render json: response, status: :not_found
    else
      data = { budget: @budget.serialized_hash }
      response = build_successful_response(:SUCCESS, data:)

      render json: response, status: :created
    end
  end

  def create; end

  def current; end

  private

  def set_budget_account
    @budget_account = current_user.budget_account
  end

  def set_budget
    @budget = Budget.find_by(uid: params[:uid])
  end
end
