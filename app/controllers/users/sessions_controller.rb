module Users
  class SessionsController < Devise::SessionsController
    private

    def respond_with(resource, _options)
      data = { user: resource.serialized_hash }
      render json: { data: }, status: :created
    end

    def respond_to_on_destroy
      head :no_content
    end
  end
end
