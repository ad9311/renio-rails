class Users::SessionsController < Devise::SessionsController
  include Api::ResponseBuilder

  private

  def respond_with(resource, _options)
    if user_signed_in?
      message = "User #{resource.username} signed in successfully"
      data = { user: resource.serialized_hash }
      response = build_successful_response(:SUCCESS, message:, data:)

      render json: response, status: :created
    else
      message = 'You need to sign in to continue'
      data = {}
      response = build_successful_response(:SUCCESS, message:, data:)

      render json: response
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
