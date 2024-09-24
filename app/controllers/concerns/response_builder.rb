module ResponseBuilder
  def build_successful_response(status, data: {}, metadata: {}, options: {})
    camelize = options.fetch(:camelize, true)
    return { status:, data:, metadata: } unless camelize

    {
      status:,
      data: data.transform_keys { |key| key.to_s.camelize(:lower) },
      metadata: metadata.transform_keys { |key| key.to_s.camelize(:lower) }
    }
  end

  def build_error_response(status, errors: [])
    { status:, errors: }
  end
end
