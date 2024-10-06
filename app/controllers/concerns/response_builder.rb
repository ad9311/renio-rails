module ResponseBuilder
  def build_successful_response(status, data: {}, metadata: {}, options: {})
    camelize = options.fetch(:camelize, true)
    return { status:, data:, metadata: } unless camelize

    {
      status:,
      data: to_camel(data),
      metadata: to_camel(metadata)
    }
  end

  def build_error_response(status, errors: [])
    { status:, errors: }
  end

  def to_camel(value)
    case value
    when Hash
      transform_hash_keys(value)
    when Array
      value.map { |v| to_camel(v) }
    else
      value
    end
  end

  private

  def transform_hash_keys(hash)
    hash.each_with_object({}) do |(key, val), result|
      camel_key = camelize_key(key)
      result[camel_key] = to_camel(val)
    end
  end

  def camelize_key(key)
    key.to_s.gsub(/_(.)/) { ::Regexp.last_match(1).upcase }
  end
end
