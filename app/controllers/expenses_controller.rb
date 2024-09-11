class ExpensesController < ApplicationController
  include ResponseBuilder

  before_action :set_budget
  before_action :set_expense, only: %i[show update destroy]

  def index
    expenses = @budget.expenses.order(created_at: :desc)
    data = { expenses: expenses.map(&:serialized_hash) }
    response = build_successful_response(:SUCCESS, data:)

    render json: response
  end

  def show
    if @expense.nil?
      errors = ["expense not found with id #{params[:id]}"]
      response = build_error_response(:ERROR_NOT_FOUND, errors:)

      render json: response, status: :not_found
    else
      data = { expense: @expense.serialized_hash }
      response = build_successful_response(:SUCCESS, data:)

      render json: response
    end
  end

  def create
    expense = @budget.expenses.new(expense_params)
    if expense.save
      data = { expense: expense.serialized_hash }
      response = build_successful_response(:SUCCESS_CREATED, data:)

      render json: response, status: :created
    else
      errors = expense.errors.full_messages
      response = build_error_response(:ERROR_NOT_CREATED, errors:)

      render json: response, status: :bad_request
    end
  end

  def update
    if @expense.update(expense_params)
      data = { expense: @expense.serialized_hash }
      response = build_successful_response(:SUCCESS_UPDATED, data:)

      render json: response
    else
      errors = @expense.errors.full_messages
      response = build_error_response(:ERROR_NOT_UPDATED, errors:)

      render json: response, status: :bad_request
    end
  end

  def destroy
    if @expense.destroy
      data = { expense: @expense.serialized_hash }
      response = build_successful_response(:SUCCESS_DELETED, data:)

      render json: response
    else
      errors = @expense.errors.full_messages
      response = build_error_response(:ERROR_NOT_DELETED, errors:)

      render json: response, status: :bad_request
    end
  end

  private

  def set_budget
    @budget = Budget.find_by(uid: params[:budget_uid])
  end

  def set_expense
    @expense = Expense.find_by(id: params[:id])
  end

  def expense_params
    params.require(:expense).permit(:transaction_type_id, :description, :amount)
  end
end
