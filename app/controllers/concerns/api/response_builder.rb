module Api::ResponseBuilder
  def build_successful_response(status, message: nil, data: {}, metadata: {})
    response = { status:, message:, data: }
    return response.merge({ metadata: }) unless metadata.empty?

    response
  end

  def build_error_response(status, errors: [])
    { status:, errors: }
  end
end
