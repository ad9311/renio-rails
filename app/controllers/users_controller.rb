class UsersController < ApplicationController
  include ResponseBuilder

  def me
    data = { user: current_user.serialized_hash }
    response = build_successful_response(:SUCCESS, data:)

    render json: response
  end
end
