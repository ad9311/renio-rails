module Serializer
  require 'active_support/core_ext/string'

  def serialized_hash(options = {})
    attributes(options)
  end

  private

  def attributes
    raise NotImplementedError, 'Subclasses must define the `attributes` method'
  end
end
