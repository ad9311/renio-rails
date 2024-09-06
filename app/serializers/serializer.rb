module Serializer
  require 'active_support/core_ext/string'

  def serialized_hash(options = {})
    camelize = options.fetch(:camelize, true)
    return attributes unless camelize

    attributes.transform_keys { |key| key.to_s.camelize(:lower) }
  end

  private

  def attributes
    raise NotImplementedError, 'Subclasses must define the `attributes` method'
  end
end
