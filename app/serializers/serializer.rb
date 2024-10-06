module Serializer
  require 'active_support/core_ext/string'

  def serialized_hash(*)
    attributes
  end

  private

  def attributes
    raise NotImplementedError, 'Subclasses must define the `attributes` method'
  end
end
