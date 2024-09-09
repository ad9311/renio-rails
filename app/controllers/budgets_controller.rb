class BudgetsController < ApplicationController
  include Api::ResponseBuilder

  before_action :set_budget_account
  before_action :set_budget, only: %i[show]

  def index
    budgets = @budget_account.budgets.order(uid: :desc)
    data = { budgets: budgets.map(&:serialized_hash) }
    response = build_successful_response(:SUCCESS, data:)

    render json: response
  end

  def show
    if @budget.nil?
      errors = ["budget not found with uid '#{params[:uid]}'"]
      response = build_error_response(:ERROR_NOT_FOUND, errors:)

      render json: response, status: :not_found
    else
      data = { budget: @budget.serialized_hash }
      response = build_successful_response(:SUCCESS, data:)

      render json: response
    end
  end

  def create
    budget = @budget_account.budgets.new(budget_params)
    if budget.save
      data = { budget: budget.serialized_hash }
      response = build_successful_response(:SUCCESS_CREATED, data:)

      render json: response, status: :created
    else
      errors = budget.errors.full_messages
      response = build_error_response(:ERROR_NOT_CREATED, errors:)

      render json: response, status: :bad_request
    end
  end

  def current
    current_date = Time.zone.now
    budget = @budget_account.budgets.find_by(year: current_date.year, month: current_date.month)
    if budget.nil?
      errors = ['user has no current budget']
      response = build_error_response(:ERROR_NOT_FOUND, errors:)

      render json: response, status: :not_found
    else
      data = { budget: budget.serialized_hash }
      response = build_successful_response(:SUCCESS, data:)

      render json: response
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:year, :month)
  end

  def set_budget_account
    @budget_account = current_user.budget_account
  end

  def set_budget
    @budget = Budget.find_by(uid: params[:uid])
  end
end
