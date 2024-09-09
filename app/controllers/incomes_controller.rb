class IncomesController < ApplicationController
  include Api::ResponseBuilder

  before_action :set_budget

  def index
    income_list = @budget.incomes.order(created_at: :desc)
    data = { income_list: income_list.map(&:serialized_hash) }
    response = build_successful_response(:SUCCESS, data:)

    render json: response
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

  private

  def set_budget
    @budget = Budget.find_by(uid: params[:budget_uid])
  end

  def income_params
    params.require(:income).permit(:transaction_type_id, :description, :amount)
  end
end
