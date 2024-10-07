class BudgetsController < ApplicationController
  include ResponseBuilder

  before_action :set_budget_account
  before_action :set_transactions_params, only: %i[show current]
  before_action :set_budget, only: %i[show]

  def index
    if params[:data] == 'count'
      budget_count = @budget_account.budgets.count
      data = { budget_count: }
      response = build_successful_response(:SUCCESS, data:)
      render(json: response) and return
    end

    expenses, income = params[:transactions]&.split(':')
    budgets = @budget_account.budgets.order(uid: :desc).limit(6)
    budgets = budgets.includes(:incomes) if income
    budgets = budgets.includes(:expenses) if expenses
    data = { budgets: budgets.map { |budget| budget.serialized_hash({ expenses:, income: }) } }
    response = build_successful_response(:SUCCESS, data:)

    render json: response
  end

  def show
    if @budget.nil?
      errors = ["budget not found with uid '#{params[:uid]}'"]
      response = build_error_response(:ERROR_NOT_FOUND, errors:)

      render json: response, status: :not_found
    else
      data = { budget: @budget.serialized_hash({ incomes: @incomes_param, expenses: @expenses_param }) }
      response = build_successful_response(:SUCCESS, data:)

      render json: response
    end
  end

  def create
    budget = @budget_account.budgets.new(Budget.new_date_params)
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
    budget = Budget.current(@budget_account, incomes: @incomes_param, expenses: @expenses_param)
    if budget.nil?
      errors = ['user has no current budget']
      response = build_error_response(:ERROR_NOT_FOUND, errors:)

      render json: response, status: :not_found
    else
      data = { budget: budget.serialized_hash({ incomes: @incomes_param, expenses: @expenses_param }) }
      response = build_successful_response(:SUCCESS, data:)

      render json: response
    end
  end

  private

  def set_budget_account
    @budget_account = current_user.budget_account
  end

  def set_transactions_params
    transactions_params = params[:transactions]&.split(':')
    @incomes_param = true if transactions_params&.any?('incomes')
    @expenses_param = true if transactions_params&.any?('expenses')
  end

  def set_budget
    @budget = Budget.find_by_uid(params[:uid], incomes: @incomes_param, expenses: @expenses_param)
  end
end
