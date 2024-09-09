module Api::ResponseBuilder
  def build_successful_response(status, data: {}, metadata: {})
    { status:, data:, metadata: }
  end

  def build_error_response(status, errors: [])
    { status:, errors: }
  end
end
