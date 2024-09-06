module Users
  class SessionsController < Devise::SessionsController
    private

    def respond_with(resource, _options)
      render json: { user: resource }, status: :created
    end

    def respond_to_on_destroy
      head :no_content
    end
  end
end
