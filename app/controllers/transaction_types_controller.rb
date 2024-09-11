class TransactionTypesController < ApplicationController
  include ResponseBuilder

  before_action :set_budget_account
  before_action :set_transaction_type, only: %i[update destroy]

  def index
    transaction_types = @budget_account.transaction_types.where(default: false).order(:name)
    data = { transaction_types: transaction_types.map(&:serialized_hash) }
    response = build_successful_response(:SUCCESS, data:)

    render json: response
  end

  def create
    transaction_type = @budget_account.transaction_types.new(transaction_type_params)
    if transaction_type.save
      data = { transaction_type: transaction_type.serialized_hash }
      response = build_successful_response(:SUCCESS_CREATED, data:)

      render json: response, status: :created
    else
      errors = transaction_type.errors.full_messages
      response = build_error_response(:ERROR_NOT_CREATED, errors:)

      render json: response, status: :bad_request
    end
  end

  def update
    if @transaction_type.update(transaction_type_params)
      data = { transaction_type: @transaction_type.serialized_hash }
      response = build_successful_response(:SUCCESS_UPDATED, data:)

      render json: response
    else
      errors = @transaction_type.errors.full_messages
      response = build_error_response(:ERROR_NOT_UPDATED, errors:)

      render json: response, status: :bad_request
    end
  end

  def destroy
    if @transaction_type.destroy
      data = { transaction_type: @transaction_type.serialized_hash }
      response = build_successful_response(:SUCCESS_DELETED, data:)

      render json: response
    else
      errors = @transaction_type.errors.full_messages
      response = build_error_response(:ERROR_NOT_DELETED, errors:)

      render json: response, status: :bad_request
    end
  end

  private

  def transaction_type_params
    params.require(:transaction_type).permit(:name, :color)
  end

  def set_budget_account
    @budget_account = current_user.budget_account
  end

  def set_transaction_type
    @transaction_type = TransactionType.find_by(id: params[:id])
  end
end
