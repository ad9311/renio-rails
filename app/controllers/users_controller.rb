class UsersController < ApplicationController
  include Api::ResponseBuilder

  def me
    message = "Session for #{current_user.username}"
    data = { user: current_user.serialized_hash }
    response = build_successful_response(:SUCCESS, message:, data:)

    render json: response
  end
end
