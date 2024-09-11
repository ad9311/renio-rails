class Users::SessionsController < Devise::SessionsController
  include ResponseBuilder

  private

  def respond_with(resource, _options)
    if user_signed_in?
      data = { user: resource.serialized_hash }
      response = build_successful_response(:SUCCESS, data:)

      render json: response, status: :created
    else
      errors = ['you need to be authenticated to access this resource']
      response = build_error_response(:ERROR_UNAUTHORIZED, errors:)

      render json: response, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
