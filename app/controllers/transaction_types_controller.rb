class TransactionTypesController < ApplicationController
  include ResponseBuilder

  def index
    transaction_types = TransactionType.order(:name)
    data = { transaction_types: transaction_types.map(&:serialized_hash) }
    response = build_successful_response(:SUCCESS, data:)

    render json: response
  end
end
