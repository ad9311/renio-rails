class IncomesController < ApplicationController
  include ResponseBuilder

  before_action :set_budget
  before_action :set_income, only: %i[show update destroy]

  def index
    income_list = @budget.incomes.order(created_at: :desc)
    data = { income_list: income_list.map(&:serialized_hash) }
    response = build_successful_response(:SUCCESS, data:)

    render json: response
  end

  def show
    if @income.nil?
      errors = ["income not found with id #{params[:id]}"]
      response = build_error_response(:ERROR_NOT_FOUND, errors:)

      render json: response, status: :not_found
    else
      data = { income: @income.serialized_hash }
      response = build_successful_response(:SUCCESS, data:)

      render json: response
    end
  end

  def create
    income = @budget.incomes.new(income_params)
    if income.save
      data = { income: income.serialized_hash }
      response = build_successful_response(:SUCCESS_CREATED, data:)

      render json: response, status: :created
    else
      errors = income.errors.full_messages
      response = build_error_response(:ERROR_NOT_CREATED, errors:)

      render json: response, status: :bad_request
    end
  end

  def update
    if @income.update(income_params)
      data = { income: @income.serialized_hash }
      response = build_successful_response(:SUCCESS_UPDATED, data:)

      render json: response
    else
      errors = @income.errors.full_messages
      response = build_error_response(:ERROR_NOT_UPDATED, errors:)

      render json: response, status: :bad_request
    end
  end

  def destroy
    if @income.destroy
      data = { income: @income.serialized_hash }
      response = build_successful_response(:SUCCESS_DELETED, data:)

      render json: response
    else
      errors = @income.errors.full_messages
      response = build_error_response(:ERROR_NOT_DELETED, errors:)

      render json: response, status: :bad_request
    end
  end

  private

  def set_budget
    @budget = Budget.find_by(uid: params[:budget_uid])
  end

  def set_income
    @income = Income.find_by(id: params[:id])
  end

  def income_params
    params.require(:income).permit(:transaction_type_id, :description, :amount)
  end
end
