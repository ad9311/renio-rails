class Users::SessionsController < Devise::SessionsController
  include Api::ResponseBuilder

  private

  def respond_with(resource, _options)
    message = "User #{resource.username} signed in successfully"
    data = { user: resource.serialized_hash }
    response = build_successful_response(:SUCCESS, message:, data:)

    render json: response, status: :created
  end

  def respond_to_on_destroy
    head :no_content
  end
end
